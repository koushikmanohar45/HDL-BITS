/*
Now that you have a state machine that will identify three-byte messages in a PS/2 byte stream, add a datapath that will also output the 24-bit (3 byte) message whenever a packet is received (out_bytes[23:16] is the first byte, out_bytes[15:8] is the second byte, etc.).

out_bytes needs to be valid whenever the done signal is asserted. You may output anything at other times (i.e., don't-care).

See also: PS/2 packet parser.
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); 
    
    parameter [1:0] BYTE1=0,BYTE2=1,BYTE3=2,DONE=3;
    reg[1:0] state,next_state;
    reg [23:0] temp;

    // FSM from fsm_ps2
    always@(*)begin
        case(state)
            BYTE1:next_state=in[3]?BYTE2:BYTE1;
            BYTE2:next_state=BYTE3;
            BYTE3:next_state=DONE;
            DONE:next_state=in[3]?BYTE2:BYTE1;
            default:next_state=BYTE1;
        endcase
    end

    // State flip-flops (sequential)
    always@(posedge clk)begin
        if(reset)
            state<=BYTE1;
        else
            state<=next_state;
    end
        
    // Output logic
    assign done=(state==DONE);

    // New: Datapath to store incoming bytes.
    always@(posedge clk)begin
        if(reset)
            temp<=24'd0;
        else begin
            if((state==BYTE1 && next_state==BYTE2)||(state==DONE && next_state==BYTE2))
            temp[23:16]=in[7:0];
            else if(state==BYTE2 && next_state==BYTE3)
            temp[15:8]=in[7:0];
        else if(state==BYTE3 && next_state==DONE)
            temp[7:0]=in[7:0];
        end
    end
    
    assign out_bytes=(state==DONE)?temp:24'd0;

endmodule

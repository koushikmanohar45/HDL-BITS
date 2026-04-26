/*
We want to add parity checking to the serial receiver. Parity checking adds one extra bit after each data byte. We will use odd parity, where the number of 1s in the 9 bits received must be odd. For example, 101001011 satisfies odd parity (there are 5 1s), but 001001011 does not.

Change your FSM and datapath to perform odd parity checking. Assert the done signal only if a byte is correctly received and its parity check passes. Like the serial receiver FSM, this FSM needs to identify the start bit, wait for all 9 (data and parity) bits, then verify that the stop bit was correct. If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.

You are provided with the following module that can be used to calculate the parity of the input stream (It's a TFF with reset). The intended use is that it should be given the input bit stream, and reset at appropriate times so it counts the number of 1 bits in each byte.

module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule

Note that the serial protocol sends the least significant bit first, and the parity bit after the 8 data bits.

See also: Serial receiver and datapath
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    parameter [2:0] IDLE=0,START=1,DATA=2,STOP=3,ERROR =4;
    reg[2:0] state,next_state;
    reg [3:0]count;
    reg [8:0] temp;  
    wire odd;
    reg p_rst;
    reg done_reg;
    
    parity p1(clk,((state==DATA) ? 1'b0:1'b1),in,odd);

    always@(*)begin
        case(state)
            IDLE:next_state=in?IDLE:DATA;
            DATA:next_state=(count==8)?STOP:DATA;
            STOP:next_state=(in)?IDLE:ERROR;
            ERROR: next_state= in ? IDLE : ERROR;
            default:next_state=IDLE;
        endcase
    end

    always@(posedge clk)begin
        if(reset)
            state<=IDLE;
        else
            state<=next_state;
    end

    always@(posedge clk)begin
        if(reset)
            count<=3'b000;
        else begin
            case(state)
                IDLE:begin
                    count<=3'b000;
                    //p_rst<=1'b1;
                end
                DATA:begin
                    count<=count+1;
                end
            endcase
        end 
    end

        


    // New: Datapath to latch input bits.
    always @(posedge clk)begin
        if(state==DATA )
            temp <= {in,temp[8:1]};
        else
            temp<=temp;
    end
    assign out_byte=(done)?temp:8'd0;
    always @(posedge clk)begin
        done <=(state== STOP && in==1 && odd);
    end

endmodule

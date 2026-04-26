/*
Now that you have a finite state machine that can identify when bytes are correctly received in a serial bitstream, add a datapath that will output the correctly-received data byte. out_byte needs to be valid when done is 1, and is don't-care otherwise.

Note that the serial protocol sends the least significant bit first.

See also: Serial receiver
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
        parameter [1:0] IDLE=0,START=1,DATA=2,STOP=3;
    reg[1:0] state,next_state;
    reg [2:0]count,count1;
    reg [7:0] temp;    

    always@(*)begin
        case(state)
            IDLE:next_state=in?IDLE:DATA;
            DATA:next_state=(count==7)?STOP:DATA;
            STOP:next_state=in?IDLE:STOP;
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
                    count1<=3'b000;
                    done<=1'b0;
                end
                DATA:begin
                    count<=count+1;
                    done<=1'b0;
                end
                STOP:begin
                    count1<=count1+1;
                if(in && count1==0)
                    done<=1'b1;
                else
                    done<=1'b0;
                end
                default done<=1'b0;
            endcase
        end 
    end

    // New: Datapath to latch input bits.
    always @(posedge clk)begin
        if(state==DATA)
            temp<={in,temp[7:1]};
        else
            temp<=temp;
    end
    assign out_byte=done?temp:8'd0;
    

endmodule

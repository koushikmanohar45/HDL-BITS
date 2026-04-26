/*
In many (older) serial communications protocols, each data byte is sent along with a start bit and a stop bit, to help the receiver delimit bytes from the stream of bits. One common scheme is to use one start bit (0), 8 data bits, and 1 stop bit (1). The line is also at logic 1 when nothing is being transmitted (idle).

Design a finite state machine that will identify when bytes have been correctly received when given a stream of bits. It needs to identify the start bit, wait for all 8 data bits, then verify that the stop bit was correct. If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter [1:0] IDLE=0,START=1,DATA=2,STOP=3;
    reg[1:0] state,next_state;
    reg [2:0]count,count1;
    

    // FSM from fsm_ps2
    always@(*)begin
        case(state)
            IDLE:next_state=in?IDLE:DATA;
            DATA:next_state=(count==7)?STOP:DATA;
            STOP:next_state=in?IDLE:STOP;
            default:next_state=IDLE;
        endcase
    end

    // State flip-flops (sequential)
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
    

endmodule

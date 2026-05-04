/*
This is the fifth component in a series of five exercises that builds a complex counter out of several smaller circuits. You may wish to do the four previous exercises first (counter, sequence recognizer FSM, FSM delay, and combined FSM).

We want to create a timer with one input that:

is started when a particular input pattern (1101) is detected,
shifts in 4 more bits to determine the duration to delay,
waits for the counters to finish counting, and
notifies the user and waits for the user to acknowledge the timer.
The serial data is available on the data input pin. When the pattern 1101 is received, the circuit must then shift in the next 4 bits, most-significant-bit first. These 4 bits determine the duration of the timer delay. I'll refer to this as the delay[3:0].

After that, the state machine asserts its counting output to indicate it is counting. The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles. e.g., delay=0 means count 1000 cycles, and delay=5 means count 6000 cycles. Also output the current remaining time. This should be equal to delay for 1000 cycles, then delay-1 for 1000 cycles, and so on until it is 0 for 1000 cycles. When the circuit isn't counting, the count[3:0] output is don't-care (whatever value is convenient for you to implement).

At that point, the circuit must assert done to notify the user the timer has timed out, and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence (1101).

The circuit should reset into a state where it begins searching for the input sequence 1101.

Here is an example of the expected inputs and outputs. The 'x' states may be slightly confusing to read. They indicate that the FSM should not care about that particular input signal in that cycle. For example, once the 1101 and delay[3:0] have been read, the circuit no longer looks at the data input until it resumes searching after everything else is done. In this example, the circuit counts for 2000 clock cycles because the delay[3:0] value was 4'b0001. The last few cycles starts another count with delay[3:0] = 4'b1110, which will count for 15000 cycles.

*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter RST=4'd0,S1=4'd1,S2=4'd2,S3=4'd3,B0=4'd4,B1=4'd5,B2=4'd6,B3=4'd7,COUNT=4'd8,WAIT=4'd9;
    reg [3:0]state,next_state;
    reg [3:0] delay;
    reg [13:0] count_delay;
	reg done_counting = 1'b0;
    
    always @(posedge clk) 
        begin 
            if(reset) 
                state<=RST; 
            else 
                state<=next_state;
		end

    always@(*) 
        begin
            case(state)
                RST:next_state=data?S1:RST;
                S1:next_state=data?S2:RST;
                S2:next_state=data?S2:S3;
                S3:next_state=data?B0:RST;
                B0:next_state=B1; 
                B1:next_state=B2; 
                B2:next_state=B3; 
                B3:next_state=COUNT;
                COUNT: next_state=done_counting?WAIT:COUNT;
                WAIT: next_state=ack?RST:WAIT;
                default: next_state=RST;
            endcase
        end
	
    always@(posedge clk) 
        begin 
            if(reset) 
                delay<=4'd0; 
            else 
                begin 
                    case(state) 
                        B0:delay[3]<=data; 
                        B1:delay[2]<=data;
                        B2:delay[1]<=data;
                        B3:delay[0]<=data;
                        default:delay<=delay;
                    endcase
                end
        end
    
    always @(posedge clk) 
        begin
            if (reset)
                count_delay<=14'd0;
            else 
                case(state)
					COUNT:count_delay<=count_delay+14'd1;
                    default: count_delay<=14'd0; 
                endcase 
        end 
    
    assign done_counting=(count_delay==((delay+1)*1000-1));
    assign count=delay-count_delay/1000; 
    assign counting=(state==COUNT); 
    assign done=(state==WAIT); 

endmodule

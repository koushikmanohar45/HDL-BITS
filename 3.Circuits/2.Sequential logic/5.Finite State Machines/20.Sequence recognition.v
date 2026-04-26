/*
Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns that indicate the beginning and end of frames (packets). Seeing exactly 6 consecutive 1s (i.e., 01111110) is a "flag" that indicate frame boundaries. To avoid the data stream from accidentally containing "flags", the sender inserts a zero after every 5 consecutive 1s which the receiver must detect and discard. We also need to signal an error if there are 7 or more consecutive 1s.

Create a finite state machine to recognize these three sequences:

0111110: Signal a bit needs to be discarded (disc).
01111110: Flag the beginning/end of a frame (flag).
01111111...: Error (7 or more 1s) (err).
When the FSM is reset, it should be in a state that behaves as though the previous input were 0.

Here are some example sequences that illustrate the desired operation
*/

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    localparam [4:0]A=0,B=1,C=2,D=3,E=4,F=5,G=6,H=7,I=8,J=9;
    reg [4:0] state,next_state;
    
    always@(posedge clk)begin
        if(reset)
            state<=A;
        else
            state<=next_state;
    end
    always@(*)begin
        case(state)
            A:next_state=in?B:A;
            B:next_state=in?C:A;
            C:next_state=in?D:A;
            D:next_state=in?E:A;
            E:next_state=in?F:A;
            F:next_state=in?G:I;
            G:next_state=in?H:J;
            H:next_state=in?H:A;
            I:next_state=in?B:A;
            J:next_state=in?B:A;
            default:next_state=A;
        endcase
    end
    
    assign disc=(state==I);
    assign flag=(state==J);
    assign err=(state==H);
    
            
            
        
    

endmodule

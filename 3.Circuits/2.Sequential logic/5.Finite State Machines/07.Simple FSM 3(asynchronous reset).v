/*
See also: State transition logic for this FSM

The following is the state transition table for a Moore state machine with one input, one output, and four states. Implement this state machine. Include an asynchronous reset that resets the FSM to state A

State	 Next state 	Output
       in=0	 in=1
  A     A	     B	    0
  B     C	     B	    0
  C	    A	     D	    0
  D	    C	     B	    1
*/

module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    
    parameter [1:0] A=0,B=1,C=2,D=3; 
    reg [1:0]state,next_state;
    // State transition logic
    always @(*) begin    
        case(state)
            A:begin
                if(in)
                    next_state=B;
                else
                    next_state=A;
              end
            B:begin
                if(in)
                    next_state=B;
                else
                    next_state=C;
            end
            C:begin
                if(in)
                    next_state=D;
                else
                    next_state=A;
            end
            D:begin
                if(in)
                    next_state=B;
                else
                    next_state=C;
            end
            default:next_state=A;
        endcase
    end

   

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin   
        if(areset)
            state<=A;
        else
            state<=next_state;
    end
     

    // Output logic
    assign out=(state==D)?1'b1:1'b0;
    

endmodule

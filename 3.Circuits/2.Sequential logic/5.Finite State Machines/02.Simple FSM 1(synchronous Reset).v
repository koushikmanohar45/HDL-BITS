/*
This is a Moore state machine with two states, one input, and one output. Implement this state machine. Notice that the reset state is B.

This exercise is the same as fsm1, but using synchronous reset.


                    reset
                      |
                      v
               +-------------+       0       +-------------+
          +--->|      B      |-------------->|      A      |<---+
          |    |   out = 1   |<--------------|   out = 0   |    |
          |    +------+------+       0       +------+------+    |
          |           |                             |           | 
          +-----------+                             +-----------+
                 1                                       1
*/

module top_module(clk, reset, in, out);
    input clk;
    input reset; 
    input in;
    output out;

    localparam A=1,B=0;
    
    reg state, next_state;

    always @(*) begin    
        case(state)
            A:begin
                if(in)
                    next_state=A;
                else
                    next_state=B;
              end
            B:begin
                if(in)
                    next_state=B;
                else
                    next_state=A;
            end
            default:next_state=B;
        endcase
    end

   always @(posedge clk ) begin   
        if(reset)
            state<=B;
        else
            state<=next_state;
    end
     assign out=(state==A)?1'b0:1'b1;

endmodule

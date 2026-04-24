/*
This is a Moore state machine with two states, two inputs, and one output. Implement this state machine.

This exercise is the same as fsm2s, but using asynchronous reset.

                    areset
                      |
                      v
               +-------------+      j = 1      +-------------+
          +--->|     OFF     |---------------->|      ON     |---+
          |    |   out = 0   |<----------------|   out = 1   |   |
          |    +-------------+      k = 1      +-------------+   |
          |           ^                               ^          |
          |           |                               |          |
          |         j = 0                           k = 0        |
          +-----------+                               +----------+

*/

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0,ON=1; 
    reg state, next_state;
    always @(*) begin    
        case(state)
            ON:begin
                if(k)
                    next_state=OFF;
                else
                    next_state=ON;
              end
            OFF:begin
                if(j)
                    next_state=ON;
                else
                    next_state=OFF;
            end
            default:next_state=OFF;
        endcase
    end

   always @(posedge clk or posedge areset) begin   
        if(areset)
            state<=OFF;
        else
            state<=next_state;
    end
    assign out=(state==OFF)?1'b0:1'b1;

endmodule

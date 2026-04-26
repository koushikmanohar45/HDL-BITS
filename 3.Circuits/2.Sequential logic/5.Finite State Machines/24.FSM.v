/*
Consider a finite state machine with inputs s and w. Assume that the FSM begins in a reset state called A, as depicted below. The FSM remains in state A as long as s = 0, and it moves to state B when s = 1. Once in state B the FSM examines the value of the input w in the next three clock cycles. If w = 1 in exactly two of these clock cycles, then the FSM has to set an output z to 1 in the following clock cycle. Otherwise z has to be 0. The FSM continues checking w for the next three clock cycles, and so on. The timing diagram below illustrates the required values of z for different values of w.

Use as few states as possible. Note that the s input is used only in state A, so you need to consider just the w input.

                   reset
                      |
                      v
               +-------------+       s=1     +-------------+
          +--->|     A/0     |-------------->|     B/0     |
          |    |             |               |             |   
          |    +------+------+               +------+------+    
          |           |                            
          +-----------+                            
                 s=0                                       

*/

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    localparam [1:0]A=0,B=1,C=2;
    reg [1:0] state,next_state;
    reg[2:0]temp;
    reg [1:0]count;
    
    always@(posedge clk )begin
        if(reset)
            state<=A;
        else
            state<=next_state;
    end
    
    always@(*)begin
        case(state)
            A:next_state=s?B:A;
            B:next_state=s?B:B;
            default:next_state=A;
        endcase
    end
    
    always@(posedge clk)begin
        if(reset)begin
            temp<=3'd0;
            count<=2'd0;
        end
         else begin
             if(state==B) begin
                 temp<={w,temp[2:1]};
                if(count==3)
                   count<=2'd1;
                else
                    count<=count+1;
              end
             
         end
    end
    
    assign z=((count==3)&&(temp==3'b101 ||temp==3'b110||temp==3'b011));

endmodule

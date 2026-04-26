/*
The following diagram is a Mealy machine implementation of the 2's complementer. Implement using one-hot encoding.

                                                      x=1/z=0
                    reset                          +------------+
                      |                            |            |
                      v                            |            |
               +-------------+               +-------------+    |
          +--->|      A      |-------------->|      B      |<---+
          |    |             |    x=1/z=1    |             |<---+
          |    +------+------+               +------+------+    |
          |           |                             |           | 
          +-----------+                             +-----------+
            x=0/z=0                                       x=0/z=1
*/

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
localparam [1:0]A=0,B=1;
    reg [1:0] state,next_state;
    
    always@(posedge clk or posedge areset)begin
        if(areset)
            state<=A;
        else
            state<=next_state;
    end
    always@(*)begin
        case(state)
            A:next_state=x?B:A;
            B:next_state=x?B:B;
            default:next_state=A;
        endcase
    end
    always@(*)begin
            case(state)
                A:begin
                    if(x)
                    z<=1'b1;
                   else
                       z<=1'b0;
                end
                B:begin
                    if(x)
                    z<=1'b0;
                  else
                      z<=1'b1;
                 end
                default:z<=1'b0;
            endcase
    end
endmodule

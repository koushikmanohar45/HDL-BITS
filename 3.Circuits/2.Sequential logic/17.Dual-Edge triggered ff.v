//You're familiar with flip-flops that are triggered on the positive edge of the clock, or negative edge of the clock. A dual-edge triggered flip-flop is triggered on both edges of the clock. However, FPGAs don't have dual-edge triggered flip-flops, and always @(posedge clk or negedge clk) is not accepted as a legal sensitivity list.

module top_module (
    input clk,
    input d,
    output  q
); 
    reg q1,q2;
    always @(posedge clk)begin
        q1<=d;
    end
    always @(negedge clk)begin
        q2<=d;
    end
    assign q=clk?q1:q2;
endmodule

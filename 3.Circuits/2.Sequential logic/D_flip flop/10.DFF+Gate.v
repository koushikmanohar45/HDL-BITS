/*
Implement the following circuit:
 +--------------------------------------------------+
 |         ______                                   |
 +-------\ \      \                                 |
          ) ) XOR  )---+                            |
IN-------/ /______/    |                            |
                       |       _____________        |
                       |------| D          Q|-------+-----OUT
                              |             |
                              |             |
CLK --------------------------|>            |
                              |_____________|
*/

module top_module (
    input clk,
    input in, 
    output out);
    wire x;
    always@(posedge clk)begin
            out<=x;
    end
    assign x=in^out;

endmodule

/*
Consider the n-bit shift register circuit shown below:

          E      L
          |      |
          +------|--------------------------------------• • • • •---------+-----------------------------------------------------+
          |      |                                                        |                                                     |
          |      +---------------------------------------• • • • •--------|------+----------------------------------------------|---------+                                     
          |      |                                                        |      |                                              |         |
 +--------|------|-----------------------------+                          |      |                                              |         |
 |       |\      |                             |                          |      |                                              |         |                 
 +-------|0|    |\                             |                     +----|------|----------------------------+          +------|---------|------------------------+
         | |----|0\                            |                     |   |\      |                            |          |      |         |                        |
 W-------|1|    |  |-----+                     |                     +---|0\    |\                            |          |    |\          |                        |
         |/  +--|1/      |    +-------------+  |                         |  |---|0\                           |          +----|0\       |\                         |       
             |  |/       +----| D          Q|--+-------• • • • •---------|1/    |  |----+   +------------+    |               |  |------|0\        +----------+    |
 R(n-1)------+                |             |  |                         |/  +--|1/     +---|D          Q|----+---------------|1/       |  |-------|D        Q|----+
                              |             |  |                             |  |/          |            |    |               |/    +---|1/        |          |    |
                  +-----------|>            |  |                     R1------+        +-----|>           |    |                     |   |/   +-----|>         |    |
                  |           +-------------+  |                                      |     +------------+    |              R0 ----+        |     |          |    |
                  |                            |                                      |                       |                              |     +----------+    |
clk---------------+----------------------------|---------• • • • •--------------------+-----------------------|------------------------------+                     |
                                               |                                                              |                                                    |
                                             Q(n-1)                                                           Q1                                                   Q0


Write a top-level Verilog module (named top_module) for the shift register, assuming that n = 4. Instantiate four copies of your MUXDFF subcircuit in your top-level module. Assume that you are going to implement the circuit on the DE2 board.

Connect the R inputs to the SW switches,
clk to KEY[0],
E to KEY[1],
L to KEY[2], and
w to KEY[3].
Connect the outputs to the red lights LEDR[3:0].
*/

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    MUXDFF m1(KEY[0],KEY[1],KEY[2],KEY[3],SW[3],LEDR[3],);
    MUXDFF m2(KEY[0],KEY[1],KEY[2],LEDR[3],SW[2],LEDR[2]);
    MUXDFF m3(KEY[0],KEY[1],KEY[2],LEDR[2],SW[1],LEDR[1]);
    MUXDFF m4(KEY[0],KEY[1],KEY[2],LEDR[1],SW[0],LEDR[0]);

endmodule

module MUXDFF (
    input clk,
    input E,L,w,R,
    output Q
);
    wire x1,x2;
    assign x1=E?w:Q;
    assign x2=L?R:x1;
    
    always@(posedge clk )begin
            Q<=x2;
    end

endmodule

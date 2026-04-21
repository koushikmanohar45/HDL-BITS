/*
Taken from 2015 midterm question 5. See also the first part of this question: mt2015_muxdff

 +-------------------------------------------------------------------------------------+-------------------------------------------------+
 |       |\                                                                            |                                                 |
 +-------|0|                                                                           |                                                 |
         | |------------+                                |\                            |                                                 |
r0-------|1|            |                        r1------|1\                           |        ______                                   |
         |/             |     +-------------+            |  |-----+                    +-----\ \       \      |\                         |                
          |             |-----| D          Q|------------|0/     |   +------------+           ) ) XOR   >o----|0\        +----------+    |
          |                   |             |            |/      +---|D          Q|----------/ /_______/      |  |-------|D        Q|----+
L---------+                   |             |             |          |            |                      r2---|1/        |          |
                  +-----------|>            |             L      +---|>           |                           |/     +---|>         |
                  |           +-------------+                    |   +------------+                            |     |   |          |
                  |                                              |                                             L     |   +----------+
clk---------------+----------------------------------------------+---------------------------------------------------+


Write the Verilog code for this sequential circuit (Submodules are ok, but the top-level must be named top_module). Assume that you are going to implement the circuit on the DE1-SoC board. Connect the R inputs to the SW switches, connect Clock to KEY[0], and L to KEY[1]. Connect the Q outputs to the red lights LEDR.
*/

module top_module (
	input [2:0] SW,       // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR); // Q
    circuit c1(KEY[0],KEY[1],SW[0],LEDR[2],LEDR[0]);
    circuit c2(KEY[0],KEY[1],SW[1],LEDR[0],LEDR[1]);
    circuit c3(KEY[0],KEY[1],SW[2],LEDR[1]^LEDR[2],LEDR[2]);
endmodule

module circuit (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    wire x;
    assign x=L?r_in:q_in;
    always@(posedge clk )begin
            Q<=x;
    end
endmodule


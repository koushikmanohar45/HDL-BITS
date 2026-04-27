/*
Taken from ECE253 2015 midterm question 5

Consider the sequential circuit below:

 +-------------------------------------------------------------------------------------+-------------------------------------------------+
 |       |\                                                                            |                                                 |
 +-------| |                                                                           |                                                 |
         | |------------+                                                              |                                                 |
r0-------| |            |                        r1------|\                            |        ______                                   |
         |/             |     +-------------+            | |-----+                     +-----\ \       \                                 |                
          |             |-----| D          Q|------------|/      |   +------------+           ) ) XOR   >o----|\         +----------+    |
          |                   |             |             |      +---|D          Q|----------/ /_______/      | |--------|D        Q|----+
L---------+                   |             |             |          |            |                      r2---|/         |          |
                  +-----------|>            |             L      +---|>           |                            |     +---|>         |
                  |           +-------------+                    |   +------------+                            |     |   |          |
                  |                                              |                                             L     |   +----------+
clk---------------+----------------------------------------------+---------------------------------------------------+

Assume that you want to implement hierarchical Verilog code for this circuit, using three instantiations of a submodule that has a flip-flop and multiplexer in it. Write a Verilog module (containing one flip-flop and multiplexer) named top_module for this submodule.

*/

module top_module (
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

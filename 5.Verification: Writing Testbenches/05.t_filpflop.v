/*
You are given a T flip-flop module with the following declaration:

module tff (
    input clk,
    input reset,   // active-high synchronous reset
    input t,       // toggle
    output q
);
Write a testbench that instantiates one tff and will reset the T flip-flop then toggle it to the "1" state.
*/

module top_module ();
 reg clk;
    reg reset;
    reg t;
    wire q;
    tff dut(clk,reset,t,q);
    
    always #5 clk=~clk;
    
    initial begin
        clk=0;reset=1'b1;t=0; 
        @(negedge clk)reset=1'b0;t=1;    
    end
endmodule

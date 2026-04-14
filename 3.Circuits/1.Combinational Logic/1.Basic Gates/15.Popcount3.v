// "population count" circuit counts the number of '1's in an input vector. Build a population count circuit for a 3-bit input vector.


module top_module( 
    input [2:0] in,
    output [1:0] out );
    wire s,c;
    assign s=^in;
    assign c=(in[0]&in[1])|(in[1]&in[2])|(in[2]&in[0]);
    assign out={c,s};
endmodule

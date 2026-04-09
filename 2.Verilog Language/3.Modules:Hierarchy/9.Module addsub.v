/*
You are provided with a 16-bit adder module, which you need to instantiate twice:
module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
Use a 32-bit wide XOR gate to invert the b input whenever sub is 1. (This can also be viewed as b[31:0] XORed with sub replicated 32 times. See replication operator.). Also connect the sub input to the carry-in of the adder.
*/

module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire c0;
    wire [31:0]c1;
    assign c1=b^{32{sub}};
    add16 m1(.a(a[15:0]),.b(c1[15:0]),.cin(sub),.cout(c0),.sum(sum[15:0]));
    add16 m2(.a(a[31:16]),.b(c1[31:16]),.cin(c0),.cout(),.sum(sum[31:16]));
    
endmodule

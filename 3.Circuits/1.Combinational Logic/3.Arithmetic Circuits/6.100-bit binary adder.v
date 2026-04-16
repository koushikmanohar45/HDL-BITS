//Create a 100-bit binary adder. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.

//Expected solution length: Around 1 line.

module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    wire[100:0]c;
    assign c[0]=cin;
    genvar i;
    generate
        for(i=0;i<100;i=i+1)begin:fa_bloclk
            full_adder fa1(.a(a[i]),.b(b[i]),.cin(c[i]),.cout(c[i+1]),.sum(sum[i]));
        end
    endgenerate
    assign cout=c[100];
endmodule
module full_adder(input a, b,
    input cin,
    output cout,
    output sum );
    assign sum= a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);
endmodule

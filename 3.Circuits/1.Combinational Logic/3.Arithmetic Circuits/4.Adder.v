module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire[2:0]c;
    FA f1(.a(x[0]),.b(y[0]),.sum(sum[0]),.cout(c[0]));
    FA f2(.a(x[1]),.b(y[1]),.sum(sum[1]),.cin(c[0]),.cout(c[1]));
    FA f3(.a(x[2]),.b(y[2]),.sum(sum[2]),.cin(c[1]),.cout(c[2]));
    FA f4(.a(x[3]),.b(y[3]),.sum(sum[3]),.cin(c[2]),.cout(sum[4]));
endmodule
module FA( 
    input a,b,cin,
    output cout,sum );
    assign sum=a^b^cin;
    assign cout=(a&b)|(b&cin)|(cin&a);
endmodule

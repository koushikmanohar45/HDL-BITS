/*
A "population count" circuit counts the number of '1's in an input vector. Build a population count circuit for a 255-bit input vector.
*/

module top_module( 
    input [254:0] in,
    output  reg [7:0] out );
    int i;
    always@(*)begin
        out=0;
        for(i=0;i<255;i=i+1)begin
            if(in[i])
                out=out+1;
            else
                out=out; 
        end
    end

endmodule

//Create a 4-bit wide, 256-to-1 multiplexer. The 256 4-bit inputs are all packed into a single 1024-bit input vector. sel=0 should select bits in[3:0], sel=1 selects bits in[7:4], sel=2 selects bits in[11:8], etc.

//Expected solution length: Around 1–5 lines.

module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out );
    integer i;
    always @(*)begin
        
               out=4'd0; 
        for(i=0;i<256;i=i+1)begin
            if(sel==i)
                out=in[((4*i)+3)-:4];
        end
    end
endmodule

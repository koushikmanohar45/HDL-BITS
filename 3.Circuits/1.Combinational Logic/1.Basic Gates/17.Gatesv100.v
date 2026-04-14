/*
You are given a 100-bit input vector in[99:0]. We want to know some relationships between each bit and its neighbour:

out_both:
    Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left are '1'. For example, out_both[98] should indicate if in[98] and in[99] are both 1. Since in[99] has no neighbour to the left, the answer is obvious so we don't need to know out_both[99].
out_any: 
    Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'. For example, out_any[2] should indicate if either in[2] or in[1] are 1. Since in[0] has no neighbour to the right, the answer is obvious so we don't need to know out_any[0].
out_different: 
     Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left. For example, out_different[98] should indicate if in[98] is different from in[99]. For this part, treat the vector as wrapping around, so in[99]'s neighbour to the left is in[0].
*/

module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    int i;
    always @(*)begin
        for(i=0;i<99;i=i+1)begin
           if(in[i]&&in[i+1])
               out_both[i]=1'b1;
           else
               out_both[i]=1'b0;
         end 
        for(i=1;i<100;i=i+1)begin
           if(in[i]||in[i-1])
               out_any[i]=1'b1;
           else
               out_any[i]=1'b0;
        end
        for(i=0;i<100;i=i+1)begin
            if(i<=98)begin
              if((in[i]&~in[i+1])||(~in[i]&in[i+1]))
                  out_different[i]=1'b1;
              else
                  out_different[i]=1'b0;
            end
            else begin
                if((in[i]&~in[0])||(~in[i]&in[0]))
                    out_different[i]=1'b1;
               else
                    out_different[i]=1'b0;
           end
        end
    end

endmodule

module top_module();
    reg in,clk;
reg[2:0]s;
wire out;
    q7 dut(clk,in,s,out);
    
    always #5 clk=~clk;
    
    initial begin
        clk=0;in=1'b0;s=3'd2; 
        @(negedge clk) in=1'b0;s=3'd6; 
        @(negedge clk) in=1'b1;s=3'd2; 
        @(negedge clk) in=1'b0;s=3'd7; 
        @(negedge clk) in=1'b1;s=3'd0;
        @(negedge clk) in=1'b1;s=3'd0; 
        @(negedge clk) in=1'b1;s=3'd0; 
        @(negedge clk) in=1'b0;s=3'd0; 
        
    end

endmodule

/*
Create a set of counters suitable for use as a 12-hour clock (with am/pm indicator). Your counters are clocked by a fast-running clk, with a pulse on ena whenever your clock should increment (i.e., once per second).

reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM. hh, mm, and ss are two BCD (Binary-Coded Decimal) digits each for hours (01-12), minutes (00-59), and seconds (00-59). Reset has higher priority than enable, and can occur even when not enabled.
*/

module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg[7:0] mm,
    output reg [7:0] ss); 
    
    always @(posedge clk)begin
        if(reset)begin
            hh<=8'h12;
            mm<=8'd0;
            ss<=8'd0;
            pm<=1'b0;
        end
        else if(ena)begin
                if(ss==8'h59) begin
                     ss<=8'd0;
                    if(mm==8'h59)begin
                         mm<=8'd0;
                        if(hh==8'h12)
                            hh<=8'h01;
                        else begin
                            if(hh[3:0]==4'h9)begin
                                  hh[3:0]<=4'h0;
                                  hh[7:4]<=hh[7:4]+1;
                             end
                            else
                                  hh[3:0]<=hh[3:0]+1;
                        end
                    end
                    else begin
                        if(mm[3:0]==4'h9)begin
                             mm[3:0]<=4'h0;
                             mm[7:4]<=mm[7:4]+1;
                        end
                        else 
                             mm[3:0]<=mm[3:0]+1;
                    end
                end
                else begin
                    if(ss[3:0]==4'h9)begin
                         ss[3:0]<=4'h0;
                         ss[7:4]<=ss[7:4]+1;
                     end
                    else
                        ss[3:0]<=ss[3:0]+1;
                end
                    if(hh==8'h11 && ss==8'h59 && mm==8'h59)
                  pm<=~pm;
             else
                  pm<=pm;
        end
    end

endmodule

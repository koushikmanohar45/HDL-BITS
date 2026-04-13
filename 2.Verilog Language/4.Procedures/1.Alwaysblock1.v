//Build an AND gate using both an assign statement and a combinational always block. (Since assign statements and combinational always blocks function identically, there is no way to enforce that you're using both methods. But you're here for practice, right?...)


module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);
    always @(*)begin
       out_alwaysblock=a&b;  
    end
    assign out_assign=a&b;

endmodule

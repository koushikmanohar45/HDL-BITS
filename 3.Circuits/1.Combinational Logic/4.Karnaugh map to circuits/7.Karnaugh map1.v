/*Consider the function f shown in the Karnaugh map below. Implement this function.

x3x4\x1x2 00  01  11  10
     \______________________
    00   | 1 | 0 | 0 | 1 |
    01   | 0 | 0 | 0 | 0 |
    11   | 1 | 1 | 1 | 0 |
    10   | 1 | 1 | 0 | 1 |
         -----------------

(The original exam question asked for simplified SOP and POS forms of the function.)*/

module top_module (
    input [4:1] x,
    output f
); 
    assign f=(~x[4]&~x[2])|(x[3]&~x[1])|(x[2]&x[3]&x[4]);
endmodule

/*
Implement the circuit described by the Karnaugh map below.

 cd\ab 00  01  11  10
     \__________________
 00   | 0 | 1 | 0 | 1 |
 01   | 1 | 0 | 1 | 0 |
 11   | 0 | 1 | 0 | 1 |
 10   | 1 | 0 | 1 | 0 |
      -----------------

Try to simplify the k-map before coding it. Try both product-of-sums and sum-of-products forms. We can't check whether you have the optimal simplification of the k-map. But we can check if your reduction is equivalent, and we can check whether you can translate a k-map into a circuit.
*/
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out= a^b^c^d;

endmodule


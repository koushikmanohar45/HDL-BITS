/*
Implement the following circuit:
      _______
A ----\       \
       )       )o---- Y
B ----/_______/

*/

module top_module (
    input in1,
    input in2,
    output out);
    assign out=~(in1|in2);
endmodule

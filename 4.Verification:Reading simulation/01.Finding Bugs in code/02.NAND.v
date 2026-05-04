/*
This three-input NAND gate doesn't work. Fix the bug(s).
You must use the provided 5-input AND gate:

module andgate ( output out, input a, input b, input c, input d, input e );

module top_module (input a, input b, input c, output out);//
    andgate inst1 ( a, b, c, out );
endmodule
*/

module top_module (input a, input b, input c, output out);//
    wire w;

    andgate inst1 (w,a,b,c,1'b1,1'b1);
    not(out,w);

endmodule

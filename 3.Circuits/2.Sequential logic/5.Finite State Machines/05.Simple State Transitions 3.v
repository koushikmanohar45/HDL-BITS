/*
The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following state encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11.

Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. Given the current state (state), compute the next_state and output (out) based on the state transition table.

State	 Next state 	Output
       in=0	 in=1
  A     A	     B	    0
  B     C	     B	    0
  C	    A	     D	    0
  D	    C	     B	    1

*/

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); 

    parameter A=0, B=1, C=2, D=3;
    always @(*)begin
        case({in,state})
            3'b000:next_state=A;
            3'b001:next_state=C;
            3'b010:next_state=A;
            3'b011:next_state=C;
            3'b100:next_state=B;
            3'b101:next_state=B;
            3'b110:next_state=D;
            3'b111:next_state=B;
            default:next_state=A;
        endcase
    end
    always @(*)begin
        case(state)
            A:out=0;
            B:out=0;
            C:out=0;
            D:out=1;
            default:out=0;
        endcase
    end

endmodule

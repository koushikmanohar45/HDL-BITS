/*
This is the second component in a series of five exercises that builds a complex counter out of several smaller circuits. See the final exercise for the overall design.

Build a finite-state machine that searches for the sequence 1101 in an input bit stream. When the sequence is found, it should set start_shifting to 1, forever, until reset. Getting stuck in the final state is intended to model going to other states in a bigger FSM that is not yet implemented. We will be extending this FSM in the next few exercises.

*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    localparam [2:0]A=0,B=1,C=2,D=3,E=4;
    reg [2:0]state,next_state;
    always@(posedge clk)begin
        if(reset)
            state<=A;
        else
            state<=next_state;
    end
    
    always @(*)begin
        case(state)
            A:next_state=data?B:A;
            B:next_state=data?C:A;
            C:next_state=data?C:D;
            D:next_state=data?E:A;
            E:next_state=E;
            default:next_state=A;
        endcase
    end
    
    assign start_shifting=(state==E);
endmodule

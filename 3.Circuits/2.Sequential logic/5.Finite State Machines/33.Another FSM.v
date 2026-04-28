/*
Consider a finite state machine that is used to control some type of motor. The FSM has inputs x and y, which come from the motor, and produces outputs f and g, which control the motor. There is also a clock input called clk and a reset input called resetn.

The FSM has to work as follows. As long as the reset input is asserted, the FSM stays in a beginning state, called state A. When the reset signal is de-asserted, then after the next clock edge the FSM has to set the output f to 1 for one clock cycle. Then, the FSM has to monitor the x input. When x has produced the values 1, 0, 1 in three successive clock cycles, then g should be set to 1 on the following clock cycle. While maintaining g = 1 the FSM has to monitor the y input. If y has the value 1 within at most two clock cycles, then the FSM should maintain g = 1 permanently (that is, until reset). But if y does not become 1 within two clock cycles, then the FSM should set g = 0 permanently (until reset).

(The original exam question asked for a state diagram only. But here, implement the FSM.)
*/

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0,B=1,C=2,D= 3,E=4,F=5,G=6,H=7,I=8;
    reg [3:0] state, next_state;
   
    always @(posedge clk)begin
        if (!resetn) 
        state<=A;
    else 
        state<=next_state;
    end
    always @(*)begin
        case (state)
        A:next_state=B;
        B:next_state=C;
        C:next_state=x?D:C;
        D:next_state=x?D:E;
        E:next_state=x?F:C;
        F:next_state=y?I:G;
        G:next_state=y?I:H;
        H:next_state=H;
        I:next_state=I;
        default:next_state=A;
    endcase
    end
    assign f=(state==B);
    assign g=(state==F||state==G||state==I);

endmodule

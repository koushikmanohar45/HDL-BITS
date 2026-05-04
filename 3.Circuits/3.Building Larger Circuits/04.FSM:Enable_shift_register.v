/*
This is the third component in a series of five exercises that builds a complex counter out of several smaller circuits. See the final exercise for the overall design.
As part of the FSM for controlling the shift register, we want the ability to enable the shift register for exactly 4 clock cycles whenever the proper bit pattern is detected. We handle sequence detection in Exams/review2015_fsmseq, so this portion of the FSM only handles enabling the shift register for 4 cycles.
Whenever the FSM is reset, assert shift_ena for 4 cycles, then 0 forever (until reset).
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg[2:0]count;
    always @(posedge clk)begin
        if(reset)
            count<=2'b0;
        else begin
            if(count==4)
                count<=count;
            else
                count<=count+1;
        end
    end
    assign shift_ena=(count<=3);

endmodule

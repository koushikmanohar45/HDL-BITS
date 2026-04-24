/*
Q4. [10] A large reservoir of water serves several users. In order to keep the level of water
sufficiently high, three sensors are placed vertically at 5-inch intervals. When the water
level is above the highest sensor (S3), the input flow rate should be zero. When the level
is below the lowest sensor (S1), the flow rate should be at maximum (both Nominal flow
valve and Supplemental flow valve opened).

The flow rate when the level is between the upper and lower sensors is determined by:
1. The water level
2. The level previous to the last sensor change

Each water level has a nominal flow rate associated with it, as shown below:

If the sensor change indicates that the previous level was lower than the current level,
the nominal flow rate should take place.

If the previous level was higher than the current level, the flow should be increased by
opening the Supplemental flow valve (controlled by ΔFR).

Draw the Moore model state diagram for the water reservoir controller.

Inputs to FSM : S1, S2, S3
Outputs      : FR1, FR2, FR3, ΔFR


                     Sensor Arrangement

                         S3   o
                              |
                              |
                         S2   o
                              |
                              |
                         S1   o
                              ^
                         Water Level


                    +---------------------------+
        S3 -------->|                           |------> FR3
        S2 -------->| Water Reservoir Controller|------> FR2
        S1 -------->|                           |------> FR1
                    +---------------------------+
                                  |
                                  +-------------> ΔFR


                 +------------------------------+
                 | Nominal Flow Rate Controller |
                 +------------------------------+

                 +------------------------------+
                 | Supplemental Flow Controller |
                 +------------------------------+



+----------------------+----------------------+----------------------------------+
| Water Level          | Sensors Asserted     | Nominal Flow Rate Inputs         |
+----------------------+----------------------+----------------------------------+
| Above S3             | S1, S2, S3           | None                             |
| Between S3 and S2    | S1, S2               | FR1                              |
| Between S2 and S1    | S1                   | FR1, FR2                         |
| Below S1             | None                 | FR1, FR2, FR3                    |
+----------------------+----------------------+----------------------------------+

Also include an active-high synchronous reset that resets the state machine to a state equivalent to if the water level had been low for a long time (no sensors asserted, and all four outputs asserted).
*/

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter [1:0] A=0,B=1,C=2,D=3; 
    reg [1:0]state,next_state;
    // State transition logic
    always @(*) begin    
        case(state)
            A:begin
                if(s[1] && !s[2] && !s[3])
                    next_state=B;
                else if(s[1] && s[2] && !s[3])
                    next_state=C;
                else if(s[1] && s[2] && s[3])
                    next_state=D;
                else
                    next_state=A;
              end
            B:begin
                if(s[1] && s[2] && !s[3]) 
                    next_state=C;
                else if(s[1]&&s[2]&&s[3])
                    next_state=D;
                else if(!s[1])
                    next_state=A;
                else
                    next_state=B;
            end
            C:begin
                if(s[1] && s[2] && s[3])
                    next_state=D;
                else if(!s[2])
                    next_state=B;
                else if(!s[2] && !s[1])
                    next_state=A;
                else
                    next_state=C;
            end
            D:begin
                if(!s[3] && s[2] && s[1])
                    next_state=C;
                else if(!s[3] && !s[2] && s[1])
                    next_state=B;
                else if(!s[3] && !s[2] && !s[1])
                    next_state=A;
                else 
                    next_state=D;
            end
            default:next_state=A;
        endcase
    end

   

    // State flip-flops with asynchronous reset
    always @(posedge clk) begin   
        if(reset)
            state<=A;
        else
            state<=next_state;
    end
     

    // Output logic
    always@(posedge clk)
        begin
            if(reset)
                dfr<=1'b1;
            else begin
                
            case({state,next_state})
                4'b0000:dfr<=dfr;
                4'b0001:dfr<=1'b0;
                4'b0010:dfr<=1'b0;
                4'b0011:dfr<=1'b0;
                4'b0100:dfr<=1'b1;
                4'b0101:dfr<=dfr;
                4'b0110:dfr<=1'b0;
                4'b0111:dfr<=1'b0;
                4'b1000:dfr<=1'b1;
                4'b1001:dfr<=1'b1;
                4'b1010:dfr<=dfr;
                4'b1011:dfr<=1'b0;
                4'b1100:dfr<=1'b1;
                4'b1101:dfr<=1'b1;
                4'b1110:dfr<=1'b1;
                4'b1111:dfr<=dfr;
                default:dfr<=1'b1;
             endcase
            end
        end    
     always@(*)
        begin          
            case(state)
                A:begin 
                    fr1=1'b1;
                    fr2=1'b1;
                    fr3=1'b1;
                end
                B:begin 
                    fr1=1'b1;
                    fr2=1'b1;
                    fr3=1'b0;
                end
                C:begin 
                    fr1=1'b1;
                    fr2=1'b0;
                    fr3=1'b0;
                end
                D:begin 
                    fr1=1'b0;
                    fr2=1'b0;
                    fr3=1'b0;
                end
                default:begin
                    fr1=1'b1;
                    fr2=1'b1;
                    fr3=1'b1;
                end
            endcase

        end
endmodule

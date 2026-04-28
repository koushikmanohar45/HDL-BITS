module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    localparam [1:0]A=0,B=1,C=2,D=3;
    reg [1:0] state,next_state;
    
    always@(posedge clk )begin
        if(!resetn)
            state<=A;
        else
            state<=next_state;
    end
    
    always@(*)begin
        case(state)
            A:begin 
                casex(r)
                    3'b000:next_state<=A;
                    3'bxx1:next_state<=B;
                    3'bx10:next_state<=C;
                    3'b100:next_state<=D;
                    default:next_state<=A;
                endcase     
            end
            B:begin 
                if(r[1])
                    next_state<=B;
                else
                    next_state<=A;   
            end
            C:begin 
                if(r[2])
                    next_state<=C;
                else
                    next_state<=A;   
            end
            D:begin 
                if(r[3])
                    next_state<=D;
                else
                    next_state<=A;
                    
            end
            default:next_state=A;
        endcase
    end
    always@(*)begin
        case(state)
            A:g<=3'b000;
            B:g<=3'b001;
            C:g<=3'b010;
            D:g<=3'b100;
            default:g<=3'b000;
        endcase
       end

endmodule

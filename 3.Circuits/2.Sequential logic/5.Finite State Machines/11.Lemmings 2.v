/*
In addition to walking left and right, Lemmings will fall (and presumably go "aaah!") if the ground disappears underneath them.

In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!". When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction.

Build a finite state machine that models this behaviour.
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );
    
    parameter[1:0] LEFT=0, RIGHT=1,FALL_L=2,FALL_R=3;
    reg [1:0]state,next_state;

    always @(*) begin
        case(state)
            LEFT:begin
                if(bump_left && ground)
                    next_state=RIGHT;
               else if(!ground)
                    next_state=FALL_L;
                else
                    next_state=LEFT;
                end
            
            RIGHT:begin
                if(bump_right && ground)
                    next_state=LEFT;
                else if(!ground)
                    next_state=FALL_R;
                else
                    next_state=RIGHT;
            end
            
            FALL_R:begin
                if(ground)
                    next_state=RIGHT;
                else 
                    next_state=FALL_R;
                end
            
            FALL_L:begin
                if(ground)
                    next_state=LEFT;
                else 
                    next_state=FALL_L;
            end
            
            default:next_state=LEFT;
        endcase
        
    end

    always @(posedge clk or posedge areset) begin
        if(areset)
            state<=LEFT;
        else
            state<=next_state;
    end
    
    always @(posedge clk) begin 
        if(!ground)
            aaah<=1'b1;
        else
            aaah<=1'b0;
    end
    

    assign walk_left =(state==LEFT);
    assign walk_right =(state==RIGHT);
endmodule

/*
Although Lemmings can walk, fall, and dig, Lemmings aren't invulnerable. If a Lemming falls for too long then hits the ground, it can splatter. In particular, if a Lemming falls for more than 20 clock cycles then hits the ground, it will splatter and cease walking, falling, or digging (all 4 outputs become 0), forever (Or until the FSM gets reset). There is no upper limit on how far a Lemming can fall before hitting the ground. Lemmings only splatter when hitting the ground; they do not splatter in mid-air.

Extend your finite state machine to model this behaviour.

Falling for 20 cycles is survivable.
Falling for 21 cycles causes splatter.

See also: Lemmings1, Lemmings2, and Lemmings3.
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter[2:0] LEFT=0, RIGHT=1,FALL_L=2,FALL_R=3,DIG_L=4,DIG_R=5,SPLAT=6;
    reg [2:0]state,next_state;
    integer count;
    always@(posedge clk or posedge areset)begin
        if(areset)
            count<=0;
        else if(state==FALL_R||state==FALL_L)
            count<=count+1;
        else if(!state==FALL_R||!state==FALL_L)
            count<=0;
        else
            count<=0;
    end

    always @(*) begin
        case(state)
            LEFT:begin
                if(!ground)
                    next_state=FALL_L;
                else if(bump_left && !dig)
                    next_state=RIGHT;
                else if(dig && ground)
                    next_state=DIG_L;
                else
                    next_state=LEFT;
                end
            
            RIGHT:begin
                if(!ground)
                    next_state=FALL_R;
                else if(bump_right && !dig)
                    next_state=LEFT;
                else if(dig && ground)
                    next_state=DIG_R;
                else
                    next_state=RIGHT;
            end
            
            FALL_R:begin
                if(ground && count<=19)
                    next_state=RIGHT;
                else if(ground && count>=20)
                    next_state=SPLAT;
                else 
                    next_state=FALL_R;
                end
            
            FALL_L:begin
                if(ground && count<=19)
                    next_state=LEFT;
                else if(ground && count>=20)
                    next_state=SPLAT;
                else 
                    next_state=FALL_L;
            end
            DIG_L:begin
                if(ground)
                    next_state=DIG_L;
                else 
                    next_state=FALL_L;
            end
            DIG_R:begin
                if(ground)
                    next_state=DIG_R;
                else 
                    next_state=FALL_R;
            end
            
            SPLAT:begin
                next_state=SPLAT;
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
    

    assign walk_left =(state==LEFT);
    assign walk_right =(state==RIGHT);
    assign digging=(state==DIG_L||state==DIG_R);
    assign aaah=(state==FALL_R||state==FALL_L);


endmodule


/*
Conway's Game of Life is a two-dimensional cellular automaton.

The "game" is played on a two-dimensional grid of cells, where each cell is either 1 (alive) or 0 (dead). At each time step, each cell changes state depending on how many neighbours it has:

0-1 neighbour: Cell becomes 0.
2 neighbours: Cell state does not change.
3 neighbours: Cell becomes 1.
4+ neighbours: Cell becomes 0.
The game is formulated for an infinite grid. In this circuit, we will use a 16x16 grid. To make things more interesting, we will use a 16x16 toroid, where the sides wrap around to the other side of the grid. For example, the corner cell (0,0) has 8 neighbours: (15,1), (15,0), (15,15), (0,1), (0,15), (1,1), (1,0), and (1,15). The 16x16 grid is represented by a length 256 vector, where each row of 16 cells is represented by a sub-vector: q[15:0] is row 0, q[31:16] is row 1, etc. (This tool accepts SystemVerilog, so you may use 2D vectors if you wish.)

load: Loads data into q at the next clock edge, for loading initial state.
q: The 16x16 current state of the game, updated every clock cycle.
The game state should advance by one timestep every clock cycle.

John Conway, mathematician and creator of the Game of Life cellular automaton, passed away from COVID-19 on April 11, 2020.
*/

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q );
    
    reg [15:0] d[15:0];
    reg [255:0] toroid;
    integer i,j,k,l,m,n;
    integer count;
    
    always @(*) begin
        for (i=0;i<16;i=i+1)begin
          d[i]=q[16*i+:16];
        end
        for (i=0;i<16;i=i+1)begin
          for (j=0;j<16;j=j+1) begin
              k=(i==15)?0:i+1;
              l=(i==0)?15:i-1;
              m=(j==15)?0:j+1;
              n=(j==0)?15:j-1;
              count=d[k][m]+d[k][j]+d[k][n]+d[i][m]+d[i][n]+d[l][m]+d[l][j]+d[l][n];
              case(count)
                2:toroid[16*i+j]=d[i][j];
                3:toroid[16*i+j]=1;
                default:toroid[16*i+j]=0;
            endcase
          end
        end
     end

    always @(posedge clk)begin
       if (load) 
           q<=data;
       else 
           q<=toroid;
    end 

endmodule

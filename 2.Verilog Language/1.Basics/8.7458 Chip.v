/* The 7458 is a chip with four AND gates and two OR gates. This problem is slightly more complex than 7420.
Create a module with the same functionality as the 7458 chip. It has 10 inputs and 2 outputs. 
You may choose to use an assign statement to drive each of the output wires, 
or you may choose to declare (four) wires for use as intermediate signals,
where each internal wire is driven by the output of one of the AND gates. 
                      +-----------------------------------------+
                      |                   7458                  | VCC
                      |                                         |
   p1a ---------------|-----------------------+                 |
   p2a ---------------|---+                   |                 |
   p2b----------------|-+ |                   |       +---------|-----p1c
                      | | |                   |       |  +------|-----p1b
                      | | |                   |       |  |      |
                      | | |   +--+--+      +--+--+    |  |      | 
                      | | +---| AND |      | AND |----+  |      | 
                      | +-----| gate|      | gate|-------+      | 
                      |       +--+--+      +--+--+              |
                      |          |            |                 | 
                      |          +----+       |        +--------|------p1f
   p2c -------------- |-----+         |       |        |        | 
   p2d -------------- |---+ |         |       |     +--+--+     | 
                      |   | |         |       |     | AND |-----|------p1d
                      |   | +----+    |       |     | gate|-----|------p1e    
                      |   |      |    |       |     +--+--+     | 
                      |   |   +--+--+ |       |         |       | 
                      |   +---| AND | |       |         |       | 
                      |       +--+--+ |       |         |       | 
                      |          |    |       |         |       | 
                      |          |    |       +------+  |       | 
                      |          |    |              |  |       | 
                      |       +----+----+          +----+----+  | 
         p2y----------|-------| OR gate |          | OR gate |--|----- p2y 
                      |       +----+----+          +----+----+  |
                      |                                         |           
                      |                                         |
                 GND  |                                         |
                      +-----------------------------------------+

*/
module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    assign p1y=((p1c&p1b&p1a)|(p1d&p1e&p1f));
    assign p2y=((p2c&p2d)|(p2a&p2b));
endmodule

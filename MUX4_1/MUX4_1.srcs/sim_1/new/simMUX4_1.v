`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 10:19:40
// Design Name: 
// Module Name: simMUX4_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simMUX4_1;
    reg[3:0] a,b,c,d;
    reg sel1,sel2;
    wire[3:0] y;
    MUX4_1 unt(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel1(sel1),
        .sel2(sel2),
        .y(y)
        );
    initial
    begin
        a<=4'b1011;
        b<=4'b0100;
        c<=4'b0101;
        d<=4'b0110;
                            
        sel1<=0;
        sel2<=0;
        
        #200
        sel1<=0;
        sel2<=1;
  
        #200
        sel1<=1;
        sel2<=0;
        
        #200
        sel1<=1;
        sel2<=1;
    end
endmodule










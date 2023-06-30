`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 09:57:40
// Design Name: 
// Module Name: MUX4_1
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


module MUX4_1(
    input wire[3:0] a,
    input wire[3:0] b,
    input wire[3:0] c,
    input wire[3:0] d,
    input wire sel1,
    input wire sel2,
    output reg[3:0] y
    );
    always @(sel1 or sel2 or a or b or c or d)
        if(!sel1&&!sel2) y=a;
        else if(!sel1&&sel2) y=b;
        else if(sel1&&!sel2) y=c;
        else y=d;
endmodule












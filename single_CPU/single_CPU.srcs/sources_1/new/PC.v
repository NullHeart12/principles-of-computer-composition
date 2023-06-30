`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 16:18:58
// Design Name: 
// Module Name: PC
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


module PC(
    input wire clk,
    input wire rst,
    output reg [7:0] pc
    );
    
    always @(posedge clk or posedge rst)
    begin
        if(pc==255||rst) pc<=0;
        else pc<=pc+1;
    end
 
endmodule












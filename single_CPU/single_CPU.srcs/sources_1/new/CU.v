`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 19:55:35
// Design Name: 
// Module Name: CU
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


module CU(
    input wire clk,
    input wire en,
    input wire pc,
    input wire [15:0] ins,//int order to judge the validity of the ins,so transfer the full ins
    input wire [15:0] result,
    output reg re,//the re of insMem
    output reg we,//the we of Regs
    output reg re1,//the re of Regs
    output reg re2,//the re of Regs
    output reg op_e,//the enable of ALU
    output reg[3:0] opcode
    );
    
    always @(pc)
    begin
        re<=1;
    end
    
    always @(*)
    begin
        if(ins!=16'hffff)//judge the ins is valide or not
        begin
            if(ins[15:9]==7'b0000000)
            begin
                re1<=1;
                re2<=1;
                op_e<=1;
                opcode<=4'b0000;
            end
        end
        else
        begin
            re1<=0;
            re2<=0;
            op_e<=0;
            opcode<=4'b1111;
        end
    end
    
    always @(*)
    begin
        if(result!=16'hffff)
            we<=1;
        else
            we<=0;
    end
    
endmodule























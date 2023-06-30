`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 19:29:08
// Design Name: 
// Module Name: ALU
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


module ALU(
    input wire clk,
    input wire op_e,
    input wire[15:0] operatorA,
    input wire[15:0] operatorB,
    input wire[3:0] opcode,
    output reg[15:0] result
    );
    
    parameter
    ADD=4'b0000,
    SUB=4'b0001,
    AND = 4'b0010,
    OR = 4'b0011,
    SLL = 4'b0100,
    SRL = 4'b0101,
    SLA = 4'b0110,
    SRA = 4'b0111;
    
    always @(*)
    begin
        if(op_e)
        begin
            case(opcode)
                ADD:result=operatorA+operatorB;
                SUB:result=operatorA-operatorB;
                AND:result=operatorA&&operatorB;
                OR:result=operatorA||operatorB;
                SLL:result=operatorA<<operatorB;
                SRL:result=operatorA>>operatorB;
                SLA:result=operatorA<<<operatorB;
                SRA:result=operatorA>>>operatorB;
                default:result=16'hffff;
            endcase
        end
        else
            result=16'hffff;    
    end
endmodule
















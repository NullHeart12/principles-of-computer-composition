`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 14:40:57
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
    input wire [15:0] operatorA,
    input wire [15:0] operatorB,
    input wire [2:0] opcode,
    output reg [15:0] result
    );
    
    parameter
    ADD = 3'b000,
    SUB = 3'b001,
    AND = 3'b010,
    OR = 3'b011,
    SLL = 3'b100,
    SRL = 3'b101,
    SLA = 3'b110,
    SRA = 3'b111;
    
    always @(*)
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
            default:result=16'h0000;
        endcase    
    end
endmodule
















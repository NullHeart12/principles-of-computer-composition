`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 15:30:16
// Design Name: 
// Module Name: simALU
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


module simALU();
    reg [15:0] operatorA, operatorB;
    reg [2:0] opcode;
    wire [15:0] result;
    
    ALU alu(
        .operatorA(operatorA),
        .operatorB(operatorB),
        .opcode(opcode),
        .result(result)
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
    
    initial
    begin
        operatorA = 16'h4745;
        operatorB = 16'h4321;
        
        opcode = ADD;
        #10
        $display("add result:%h",result);
        
        opcode = SUB;
        #10
        $display("sub result:%h",result);
        
        opcode = AND;
        #10
        $display("and result:%h",result);
        
        opcode = OR;
        #10
        $display("or result:%h",result);
        
        operatorB = 16'h0002;
        opcode = SLL;
        #10
        $display("sll result:%h",result);
        
        opcode = SRL;
        #10
        $display("srl result:%h",result);
        
        opcode = SLA;
        #10
        $display("sla result:%h",result);
        
        opcode = SRA;
        #10
        $display("sra result:%h",result);
        
        //$finish;
    end    
endmodule













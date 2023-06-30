`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/13 08:26:38
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
    input wire op_e,                 // Operation enable signal
    input wire [4:0] opcode,         // Operation code
    
    input wire [31:0] rdata1,        // Data input 1
    input wire [31:0] rdata2,        // Data input 2
    input wire [11:0] imm,           // Immediate value
    output reg [31:0] result,        // Result
    
    input wire [11:0] offset,        // Offset
    input wire [31:0] base,          // Base address
    output reg [31:0] valide_addr,   // Valid address
    
    input wire [19:0] jal_offset,    // JAL offset
    input wire [9:0] ins_addr,       // Instruction address
    output reg [9:0] set_addr,       // Set address
    
    input wire [31:0] cmp_data1,     // Compare data 1
    input wire [31:0] cmp_data2,     // Compare data 2
    output reg [3:0] cmp_result,     // Compare result
    
    input wire [11:0] B_offset       // Branch offset
    );
    
    parameter
    // R type RISC-V instruction
    rXOR = 5'b00001,
    rOR = 5'b00010,
    rSLL = 5'b00011,
    rSRL = 5'b00100,
    rSRA = 5'b00101,
    rADD = 5'b00110,
    // I type RISC-V instruction
    XORi = 5'b01011,
    ORi = 5'b01100,
    SLLi = 5'b01101,
    SRLi = 5'b01110,
    SRAi = 5'b01111,
    ADDi = 5'b10000,
    ADD_addr = 5'b11101,            // Used to calculate the valid address of load/store instruction
    ADD_J = 5'b11110,
    CMP = 5'b11111,
    ADD_B = 5'b11100;
    
    always @(*)
    begin
        if (op_e)
        begin
            result <= 32'hffffffff;             // Invalid result
            valide_addr <= 32'hffffffff;        // Invalid address
            set_addr <= 10'b1111111111;
            cmp_result <= 4'b0000;
            
            case (opcode)
                // R type
                rXOR: result <= rdata1 ^ rdata2;
                rOR: result <= rdata1 | rdata2;
                rSLL: result <= rdata1 << rdata2;
                rSRL: result <= rdata1 >> rdata2;
                rSRA: result <= rdata1 >>> rdata2;
                rADD: result <= rdata1 + rdata2;
                // I type
                XORi: result <= rdata1 ^ imm;
                ORi: result <= rdata1 | imm;
                SLLi: result <= rdata1 << imm;
                SRLi: result <= rdata1 >> imm;
                SRAi: result <= rdata1 >>> imm;
                ADDi: result <= rdata1 + imm;
                
                ADD_addr: valide_addr <= offset + base;    // Calculate the valid address of load/store instruction
                
                ADD_J: set_addr <= jal_offset * 4 + ins_addr;
                
                ADD_B: set_addr <= B_offset * 4 + ins_addr;
                
                CMP:    // Compare operation
                begin
                    if (cmp_data1 == cmp_data2)
                        cmp_result[0] <= 1;
                    else
                        cmp_result[0] <= 0;
                    
                    if (cmp_data1 != cmp_data2)
                        cmp_result[1] <= 1;
                    else
                        cmp_result[1] <= 0;
                    
                    if (cmp_data1 < cmp_data2)
                        cmp_result[2] <= 1;
                    else
                        cmp_result[2] <= 0;
                    
                    if (cmp_data1 >= cmp_data2)
                        cmp_result[3] <= 1;
                    else
                        cmp_result[3] <= 0;
                end
            endcase
        end
        else
        begin
            result <= 32'hffffffff;             // Invalid result
            valide_addr <= 32'hffffffff;        // Invalid address
            set_addr <= 32'hffffffff;
            cmp_result <= 4'b0000;
        end
    end    
    
endmodule

















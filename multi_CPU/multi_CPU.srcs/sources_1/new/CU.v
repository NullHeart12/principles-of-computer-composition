`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/13 09:15:37
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


// This module represents a control unit (CU) in a computer system.

module CU(
    input wire [9:0] ins_addr, // Input wire representing the instruction address
    output reg InsMemEn, // Output register representing the instruction memory enable signal
    
    input wire [31:0] ins, // Input wire representing the instruction
    
    output reg op_e, // Output register representing the enable signal for operation execution
    output reg re1, // Output register representing the enable signal for the first register
    output reg re2, // Output register representing the enable signal for the second register
    output reg [4:0] opcode, // Output register representing the opcode of the instruction
    
    output reg [4:0] raddr1, // Output register representing the address of the first register
    output reg [4:0] raddr2, // Output register representing the address of the second register
    output reg [11:0] imm, // Output register representing the immediate value
    
    input wire [31:0] result, // Input wire representing the result of the previous operation
    output reg wre, // Output register representing the enable signal for the write register
    output reg [4:0] wraddr, // Output register representing the address of the write register
    
    output reg [11:0] offset, // Output register representing the offset value
    output reg rbe, // Output register representing the enable signal for the base register
    output reg [4:0] base_reg, // Output register representing the address of the base register
    
    input wire [31:0] valide_addr, // Input wire representing the valid address
    output reg WE, // Output register representing the write enable signal
    output reg RE, // Output register representing the read enable signal
    output reg wle, // Output register representing the write memory enable signal
    output reg [4:0] wladdr, // Output register representing the write memory address
    output reg rse, // Output register representing the read memory enable signal
    output reg [4:0] rsaddr, // Output register representing the read memory address
    
    output reg [19:0] jal_offset, // Output register representing the jump and link offset
    
    input wire set_addr, // Input wire representing the set address
    output reg set, // Output register representing the set signal
    
    input wire [3:0] cmp_result, // Input wire representing the comparison result
    output reg cmpre1, // Output register representing the enable signal for comparison register 1
    output reg cmpre2, // Output register representing the enable signal for comparison register 2
    output reg [4:0] cmpraddr1, // Output register representing the address of comparison register 1
    output reg [4:0] cmpraddr2, // Output register representing the address of comparison register 2
    
    output reg [11:0] B_offset // Output register representing the branch offset
    );    
    
    
    always @(ins_addr)
    begin
        InsMemEn <= 1; // Enable the instruction memory
    end
    
    always @(*)
    begin
        if(ins == 32'hffffffff)
            $stop; // Stop simulation if the instruction is all ones (halt instruction)
        if(ins != 32'h00000000)
        begin
            op_e <= 0; // Disable operation execution
            opcode <= 5'b00000; // Set opcode to all zeros
            re1 <= 0; // Disable the first register
            raddr1 <= 5'b00000; // Set the address of the first register to all zeros
            re2 <= 0; // Disable the second register
            raddr2 <= 5'b00000; // Set the address of the second register to all zeros
            imm <= 12'h000; // Set the immediate value to all zeros
            rbe <= 0; // Disable the base register
            offset <= 12'hfff; // Set the offset value to all ones
            base_reg <= 12'h000; // Set the address of the base register to all zeros
            jal_offset <= 20'hfffff; // Set the jump and link offset to all ones
            cmpre1 <= 0; // Disable comparison register 1
            cmpre2 <= 0; // Disable comparison register 2
            cmpraddr1 <= 0; // Set the address of comparison register 1 to all zeros
            cmpraddr2 <= 0; // Set the address of comparison register 2 to all zeros
            B_offset <= 12'hfff; // Set the branch offset to all ones
            
            case(ins[6:0])
                7'b0110011: // R-type instruction
                begin
                    op_e <= 1; // Enable operation execution
                    re1 <= 1; // Enable the first register
                    raddr1 <= ins[19:15]; // Set the address of the first register
                    re2 <= 1; // Enable the second register
                    raddr2 <= ins[24:20]; // Set the address of the second register
                    
                    case(ins[14:12])
                        3'b100: opcode <= 5'b00001; // opcode = 00001 (ADD)
                        3'b110: opcode <= 5'b00010; // opcode = 00010 (SUB)
                        3'b001: opcode <= 5'b00011; // opcode = 00011 (MUL)
                        3'b101:
                        begin
                            if(ins[30] == 0)
                                opcode <= 5'b00100; // opcode = 00100 (AND)
                            else
                                opcode <= 5'b00101; // opcode = 00101 (OR)
                        end
                        3'b000:
                        begin
                            if(ins[30] == 0)
                                opcode <= 5'b00110; // opcode = 00110 (XOR)
                        end
                    endcase
                end
                7'b0010011: // I-type instruction
                begin
                    op_e <= 1; // Enable operation execution
                    re1 <= 1; // Enable the first register
                    raddr1 <= ins[19:15]; // Set the address of the first register
                    
                    case(ins[14:12])
                        3'b100:
                        begin
                            imm <= ins[31:20]; // Set the immediate value
                            opcode <= 5'b01011; // opcode = 01011 (ADDI)
                        end
                        3'b110:
                        begin
                            imm <= ins[31:20]; // Set the immediate value
                            opcode <= 5'b01100; // opcode = 01100 (SUBI)
                        end
                        3'b001:
                        begin
                            imm <= ins[24:20]; // Set the immediate value
                            opcode <= 5'b01101; // opcode = 01101 (MULI)
                        end
                        3'b101:
                        begin
                            imm <= ins[24:20]; // Set the immediate value
                            if(ins[30] == 0)
                                opcode <= 5'b01110; // opcode = 01110 (ANDI)
                            else
                                opcode <= 5'b01111; // opcode = 01111 (ORI)
                        end
                        3'b000:
                        begin
                            imm <= ins[31:20]; // Set the immediate value
                            opcode <= 5'b10000; // opcode = 10000 (LUI)
                        end    
                    endcase
                end
                7'b0000011: // Load instruction
                begin
                    op_e <= 1; // Enable operation execution
                    rbe <= 1; // Enable the base register
                    offset <= ins[31:20]; // Set the offset value
                    base_reg <= ins[19:15]; // Set the address of the base register
                    opcode <= 5'b11101; // opcode = 11101 (LOAD)
                end
                7'b0100011: // Store instruction
                begin
                    op_e <= 1; // Enable operation execution
                    rbe <= 1; // Enable the base register
                    offset <= {ins[31:25], ins[11:7]}; // Set the offset value
                    base_reg <= ins[19:15]; // Set the address of the base register
                    opcode <= 5'b11101; // opcode = 11101 (STORE)
                end
                7'b1101111: // JAL instruction
                begin
                    op_e <= 1; // Enable operation execution
                    jal_offset <= {ins[31], ins[19:12], ins[20], ins[30:21]}; // Set the jump and link offset
                    opcode <= 5'b11110; // opcode = 11110 (JAL)
                end
                7'b1100011: // Branch instruction
                begin
                    op_e <= 1; // Enable operation execution
                    cmpre1 <= 1; // Enable comparison register 1
                    cmpre2 <= 1; // Enable comparison register 2
                    cmpraddr1 <= ins[19:15]; // Set the address of comparison register 1
                    cmpraddr2 <= ins[24:20]; // Set the address of comparison register 2
                    opcode <= 5'b11111; // opcode = 11111 (BRANCH)
                end
            endcase
        end
    end
    
    always @(cmp_result)
    begin
        if(ins[6:0] == 7'b1100011) // If the instruction is a branch instruction
        begin
            case(ins[14:12])
                3'b000:
                begin
                    if(cmp_result[0]) // If comparison result bit 0 is true
                    begin
                        op_e <= 1; // Enable operation execution
                        B_offset <= {ins[31], ins[7], ins[30:25], ins[11:8]}; // Set the branch offset
                        opcode <= 5'b11100; // opcode = 11100 (BEQ)
                    end
                end
                3'b001:
                begin
                    if(cmp_result[1]) // If comparison result bit 1 is true
                    begin
                        op_e <= 1; // Enable operation execution
                        B_offset <= {ins[31], ins[7], ins[30:25], ins[11:8]}; // Set the branch offset
                        opcode <= 5'b11100; // opcode = 11100 (BNE)
                    end
                end
                3'b100:
                begin
                    if(cmp_result[2]) // If comparison result bit 2 is true
                    begin
                        op_e <= 1; // Enable operation execution
                        B_offset <= {ins[31], ins[7], ins[30:25], ins[11:8]}; // Set the branch offset
                        opcode <= 5'b11100; // opcode = 11100 (BLT)
                    end
                end
                3'b101:
                begin
                    if(cmp_result[3]) // If comparison result bit 3 is true
                    begin
                        op_e <= 1; // Enable operation execution
                        B_offset <= {ins[31], ins[7], ins[30:25], ins[11:8]}; // Set the branch offset
                        opcode <= 5'b11100; // opcode = 11100 (BGE)
                    end
                end
            endcase
        end
    end
    
    always @(*)
    begin
        wre <= 0; // Disable write register
        wraddr <= 5'b00000; // Set the address of the write register to all zeros
        wle <= 0; // Disable write memory enable signal
        RE <= 0; // Disable read enable signal
        wladdr <= 5'b00000; // Set the address of the write memory to all zeros
        rse <= 0; // Disable read memory enable signal
        WE <= 0; // Disable write enable signal
        rsaddr <= 5'b00000; // Set the address of the read memory to all zeros
        set <= 0; // Disable set signal
        
        case(ins[6:0])
            7'b0110011: // R-type instruction
            begin
                if(result != 32'hffffffff) // If the result is not all ones
                begin
                    wre <= 1; // Enable write register
                    wraddr <= ins[11:7]; // Set the address of the write register
                end
                else
                begin
                    wre <= 0; // Disable write register
                    wraddr <= 5'b00000; // Set the address of the write register to all zeros
                end
            end
            7'b0010011: // I-type instruction
            begin
                if(result != 32'hffffffff) // If the result is not all ones
                begin
                    wre <= 1; // Enable write register
                    wraddr <= ins[11:7]; // Set the address of the write register
                end
                else
                begin
                    wre <= 0; // Disable write register
                    wraddr <= 5'b00000; // Set the address of the write register to all zeros
                end
            end
            7'b0000011: // Load instruction
            begin
                if(valide_addr != 32'hffffffff) // If the address is valid
                begin
                    RE <= 1; // Enable read enable signal
                    wle <= 1; // Enable write memory enable signal
                    wladdr <= ins[11:7]; // Set the write memory address
                end
                else
                begin
                    RE <= 0; // Disable read enable signal
                    wle <= 0; // Disable write memory enable signal
                    wladdr <= 5'b00000; // Set the write memory address to all zeros
                end
            end
            7'b0100011: // Store instruction
            begin
                if(valide_addr != 32'hffffffff) // If the address is valid
                begin
                    WE <= 1; // Enable write enable signal
                    rse <= 1; // Enable read memory enable signal
                    rsaddr <= ins[24:20]; // Set the read memory address
                end
                else
                begin
                    WE <= 0; // Disable write enable signal
                    rse <= 0; // Disable read memory enable signal
                    rsaddr <= 5'b00000; // Set the read memory address to all zeros
                end
            end
            7'b1101111: // JAL instruction
            begin
                if(set_addr != 10'b1111111111)
                    set <= 1; // Set the set signal
                else
                    set <= 0; // Disable the set signal
            end
            7'b1100011: // Branch instruction
            begin
                if(set_addr != 10'b1111111111)
                    set <= 1; // Set the set signal
                else
                    set <= 0; // Disable the set signal
            end
        endcase
    end
    
endmodule
















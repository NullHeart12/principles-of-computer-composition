`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 15:04:51
// Design Name: 
// Module Name: single_CPU
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


module single_CPU(
    input wire clk,
    input wire rst,
    output reg sth
    );
    
    wire [7:0] addr;//the address of insMem and pc
    wire re;//the enable of insMem
    wire [15:0] ins;
    wire we;
    wire re1,re2;
    wire [15:0] rdata1,rdata2;
    wire op_e;//ALU opcode enable
    wire [15:0] result;
    wire [3:0] opcode;
    wire en=1'b1;//the enable of CU
            
    PC pc(.clk(clk), .rst(rst), .pc(addr));
    insMem ins_mem(.re(re), .addr(addr), .ins(ins));
    Regs regs(.clk(clk), .we(we), .waddr(ins[2:0]),//the format of the instruction is fixed,so transfer the particular bits to the regs.so do the read
         .wdata(result), .re1(re1), .raddr1(ins[8:6]), .rdata1(rdata1), .re2(re2), .raddr2(ins[5:3]), .rdata2(rdata2));
    ALU alu(.clk(clk), .op_e(op_e), .operatorA(rdata1), .operatorB(rdata2), .opcode(opcode), .result(result));
    CU cu(.clk(clk), .en(en), .pc(addr), .ins(ins), .result(result), .re(re), .we(we), .re1(re1), .re2(re2), .op_e(op_e), .opcode(opcode));
        
endmodule




















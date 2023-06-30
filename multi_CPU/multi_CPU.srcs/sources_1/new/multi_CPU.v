`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/12 20:55:18
// Design Name: 
// Module Name: multi_CPU
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


module multi_CPU(
    input wire clk,
    input wire rst,
    output reg sth
    );
    
    wire set;
    wire [9:0] set_addr;
    wire [9:0] ins_addr;
    
    wire InsMemEn;
    //ins_addr
    wire [31:0] ins;
    
    wire WE;
    //wire [7:0] wdata_addr;
    //wire [31:0] data_in;
    wire RE;
    //wire [7:0] rdata_addr;
    //wire [31:0] data_out;
    
    wire we;
    wire [4:0] waddr;
    wire [31:0] wdata;
//    wire wre;
//    wire [4:0] wraddr;
    wire wre;
    wire [4:0] wraddr;
    wire [31:0] result;
    wire re1;
    wire [4:0] raddr1;
    wire [31:0] rdata1;
    wire re2;
    wire [4:0] raddr2;
    wire [31:0] rdata2;
    wire rbe;
    wire [4:0] rbaddr;
    wire [31:0] rbdata;
    wire wle;
    wire [4:0] wladdr;
    wire [31:0] wldata;
    wire rse;
    wire [4:0] rsaddr;
    wire [31:0] rsdata;
    wire cmpre1;
    wire cmpre2;
    wire [4:0] cmpraddr1;
    wire [4:0] cmpraddr2;
    wire [31:0] cmprdata1;
    wire [31:0] cmprdata2;
    
    wire op_e;
    wire [4:0] opcode;
    //rdata1,
    //rdata2,
    wire [11:0] imm;
    //wire [31:0] result;
    wire [11:0] offset;
    //wire [31:0] base;
    wire [31:0] valide_addr;
    wire [19:0] jal_offset;
    //ins_addr;
    //set_addr,
    //wire [31:0] cmp_data1;
    //wire [31:0] cmp_data2;
    wire [3:0] cmp_result;
    wire [11:0] B_offset;
    
    
    PC pc(
        .clk(clk),
        .rst(rst),
        .set(set),
        .set_addr(set_addr),
        .ins_addr(ins_addr)
    );
    
    insMem ins_mem(
        .InsMemEn(InsMemEn),
        .ins_addr(ins_addr),
        .ins(ins)
    );
    
    dataMem data_mem(
        .WE(WE),
        .wdata_addr(valide_addr),
        .data_in(rsdata),
        .RE(RE),
        .rdata_addr(valide_addr),
        .data_out(wldata)
    );
    
    Regs regs(
        .we(we),
        .waddr(waddr),
        .wdata(wdata),
        .wre(wre),
        .wraddr(wraddr),
        .wrdata(result),
        .re1(re1),
        .raddr1(raddr1),
        .rdata1(rdata1),
        .re2(re2),
        .raddr2(raddr2),
        .rdata2(rdata2),
        .rbe(rbe),
        .rbaddr(rbaddr),
        .rbdata(rbdata),
        .wle(wle),
        .wladdr(wladdr),
        .wldata(wldata),
        .rse(rse),
        .rsaddr(rsaddr),
        .rsdata(rsdata),
        .cmpre1(cmpre1),
        .cmpre2(cmpre2),
        .cmpraddr1(cmpraddr1),
        .cmpraddr2(cmpraddr2),
        .cmprdata1(cmprdata1),
        .cmprdata2(cmprdata2)
    );
    
    ALU alu(
        .op_e(op_e),
        .opcode(opcode),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .imm(imm),
        .result(result),
        .offset(offset),
        .base(rbdata),
        .valide_addr(valide_addr),
        .jal_offset(jal_offset),
        .ins_addr(ins_addr),
        .set_addr(set_addr),
        .cmp_data1(cmprdata1),
        .cmp_data2(cmprdata2),
        .cmp_result(cmp_result),
        .B_offset(B_offset)
    );
    
    CU cu(
        .ins_addr(ins_addr),
        .InsMemEn(InsMemEn),
        .ins(ins),
        .op_e(op_e),
        .re1(re1),
        .re2(re2),
        .opcode(opcode),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .imm(imm),
        .result(result),
        .wre(wre),
        .wraddr(wraddr),
        .offset(offset),
        .rbe(rbe),
        .base_reg(rbaddr),
        .valide_addr(valide_addr),
        .WE(WE),
        .RE(RE),
        .wle(wle),
        .wladdr(wladdr),
        .rse(rse),
        .rsaddr(rsaddr),
        .jal_offset(jal_offset),
        .set_addr(set_addr),
        .set(set),
        .cmp_result(cmp_result),
        .cmpre1(cmpre1),
        .cmpre2(cmpre2),
        .cmpraddr1(cmpraddr1),
        .cmpraddr2(cmpraddr2),
        .B_offset(B_offset)
    );
    
endmodule






















`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 17:03:06
// Design Name: 
// Module Name: Regs
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


module Regs(
    input wire clk,
    
    input wire we,
    input wire[2:0] waddr,
    input wire[15:0] wdata,
    
    input wire re1,
    input wire[2:0] raddr1,
    output reg[15:0] rdata1,
    
    input wire re2,
    input wire[2:0] raddr2,
    output reg[15:0] rdata2     
    );
    
    reg[15:0] regs[7:0];
    
    initial
    begin
        regs[0]<=16'h4745;
        regs[1]<=16'h1234;
        regs[3]<=16'habcd;
        regs[4]<=16'hdcba;
    end
    
    always @(*)
    begin
        if(we)
        begin
            regs[waddr]<=wdata;
            if(re1&&waddr==raddr1)
                rdata1<=wdata;
            if(re2&&waddr==raddr2)
                rdata2<=wdata;
        end
    end
    
    always @(*)
    begin
        if(re1)
        begin
            if(raddr1<=7)
                rdata1<=regs[raddr1];
            else
                rdata1<=16'hffff;//16'hffff is the symbol of the invalide state
        end    
        else
            rdata1<=16'hffff;
    end
    
    always @(*)
    begin
        if(re2)
        begin
            if(raddr2<=7)
                rdata2<=regs[raddr2];
            else
                rdata2<=16'hffff;
        end    
        else
            rdata2<=16'hffff;
    end
endmodule
















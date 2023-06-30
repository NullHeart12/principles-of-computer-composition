`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 18:38:04
// Design Name: 
// Module Name: Register
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


//module Register(
//    input wire clk,
    
//    input wire re1,
//    input wire[2:0] raddr1,
//    output reg[15:0] rdata1,
    
//    input wire re2,
//    input wire[2:0] raddr2,
//    output reg[15:0] rdata2,
    
//    input wire we,
//    input wire[2:0] waddr,
//    input wire[15:0] wdata
//    );
    
//    reg [15:0] registers[7:0];
    
//    always @(posedge clk)
//    begin
//        if(we==0)
//        begin
//            if(re1==0&&waddr==raddr1)
//            begin
//                rdata1<=wdata;
//            end
//            if(re2==0&&waddr==raddr2)
//            begin
//                rdata2<=wdata;
//            end
//            registers[waddr]<=wdata;
//        end
//    end
    
//    always @(*)
//    begin
//        if(re1==0&&raddr1>=0&&raddr1<=7) rdata1<=registers[raddr1];
//        else if(re1==1) rdata1<=16'hx;
//    end
    
//    always @(*)
//    begin
//        if(re2==0&&raddr2>=0&&raddr2<=7) rdata2<=registers[raddr2];
//        else if(re2==1) rdata2<=16'hx;
//    end 
//endmodule



module Register(
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
    
    always @(posedge clk)
    begin
        if(!we)
        begin
            regs[waddr]<=wdata;
            if(!re1&&waddr==raddr1)
                rdata1<=wdata;
            if(!re2&&waddr==raddr2)
                rdata2<=wdata;
        end
    end
    
    always @(*)
    begin
        if(!re1)
        begin
            if(raddr1<=7)
                rdata1<=regs[raddr1];
            else
                rdata1<=16'hffff;//ffff is the symbol of the invalide state
        end    
        else
            rdata1<=16'hffff;
    end
    
    always @(*)
    begin
        if(!re2)
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

























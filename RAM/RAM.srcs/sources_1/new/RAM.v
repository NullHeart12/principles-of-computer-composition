`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 12:54:11
// Design Name: 
// Module Name: RAM
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


module RAM(
    input wire clk,
    input wire wr_e,
    input wire[9:0] addr,
    input wire[15:0] wdata,
    output reg[15:0] rdata
    );
    
    reg [7:0] mem[1023:0];//按字节编址
    
    always @(posedge clk)
    begin
        if(addr>=0&&addr<=1023) 
        begin
            if(wr_e==1)//写入
            begin
                //采用小端对齐方式
                mem[addr]<=wdata[7:0];
                mem[addr+1]<=wdata[15:8];
            end
            else if(wr_e==0)//读取
            begin
                rdata[7:0]<=mem[addr];
                rdata[15:8]<=mem[addr+1];
            end
            else if(wr_e===1'bx) rdata<=16'hx;
        end
        else if(!wr_e) rdata<=16'hx;
        if(addr===10'bx||wr_e===1'bx) rdata<=16'hx;
    end
    
endmodule



























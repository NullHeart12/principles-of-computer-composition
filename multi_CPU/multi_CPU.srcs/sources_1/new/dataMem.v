`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/12 21:39:37
// Design Name: 
// Module Name: dataMem
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


module dataMem(
    input wire WE,
    input wire [9:0] wdata_addr,
    input wire [31:0] data_in,

    input wire RE,
    input wire [9:0] rdata_addr,
    output reg [31:0] data_out
    );
    
    reg [7:0] mem[1023:0];//the size of dataMem is 1k*8bits,and memory is addressed by byte
    
    initial
    begin
        mem[3]<=8'b00000100;//4
        mem[2]<=8'b00000111;//7
        mem[1]<=8'b00000100;//4
        mem[0]<=8'b00000101;//5
        
        mem[384]<=8'b00000100;//4
        mem[385]<=8'b00000111;//7
        mem[386]<=8'b00000100;//4
        mem[387]<=8'b00000101;//5        
        
        mem[579]<=8'b00000001;//1
        mem[578]<=8'b00000010;//2
        mem[577]<=8'b00000011;//3
        mem[576]<=8'b00000100;//4
        
        mem[803]<=8'b00000100;//4
        mem[802]<=8'b00000011;//3
        mem[801]<=8'b00000010;//2
        mem[800]<=8'b00000001;//1
        
        mem[16]<=8'h0a;
        mem[17]<=8'h0b;
        mem[18]<=8'h0c;
        mem[19]<=8'h0d;
        
        mem[20]<=8'h0d;
        mem[21]<=8'h0c;
        mem[22]<=8'h0b;
        mem[23]<=8'h0a;
        
        mem[27]<=8'h08;
        mem[26]<=8'h08;
        mem[25]<=8'h04;
        mem[24]<=8'h08;
        
        mem[31]<=8'h0d;
        mem[30]<=8'h0d;
        mem[29]<=8'h0c;
        mem[28]<=8'h0c;        
    end
    
    
    always @(*)//write (maybe use { } is better?)
    begin
        if(WE&&wdata_addr<=1020)
        begin
            mem[wdata_addr]<=data_in[7:0];
            mem[wdata_addr+1]<=data_in[15:8];
            mem[wdata_addr+2]<=data_in[23:16];
            mem[wdata_addr+3]<=data_in[31:24];
        end
    end   
    
    always @(*)//read
    begin
        if(RE&&rdata_addr<=1020)
        begin
            data_out[7:0]<=mem[rdata_addr];
            data_out[15:8]<=mem[rdata_addr+1];
            data_out[23:16]<=mem[rdata_addr+2];
            data_out[31:24]<=mem[rdata_addr+3];
        end
        else
            data_out<=16'h0000;//the symbol of invalide data
    end
    
endmodule


















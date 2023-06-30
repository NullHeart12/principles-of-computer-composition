`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/12 09:18:22
// Design Name: 
// Module Name: simCPU
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


module simCPU();
    reg clk;
    reg rst;
    
    single_CPU cpu(
        .clk(clk),
        .rst(rst)
    ); 
    
    initial
    begin
        clk=1;
        rst=1;
        #100 rst=0;
    end
    
    always 
        #50 clk=~clk;
endmodule






















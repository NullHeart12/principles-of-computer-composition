`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/13 21:33:56
// Design Name: 
// Module Name: sim_CPU
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


module sim_CPU();
    reg clk;
    reg rst;

    multi_CPU cpu(
        .clk(clk),
        .rst(rst)
    );
    
    initial
    begin
        clk=1;
        rst=1;
        #100 rst=0;
    end
    
    always #50 clk=~clk;
    
endmodule



















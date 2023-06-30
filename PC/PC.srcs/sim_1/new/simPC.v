`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 11:08:52
// Design Name: 
// Module Name: simPC
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


module simPC();
    reg clk,rst;
    wire [7:0] pc;
    
    PC mypc(
        .clk(clk),
        .rst(rst),
        .pc(pc)
    );
    
    initial
    begin
        clk=1;
        
        forever
        begin
            if($time%140==0) rst=1;
            else rst=0;
            
            if($time>=520) $stop;
            
            #5
            clk=~clk;
        end
    end
endmodule










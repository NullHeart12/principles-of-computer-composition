`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 13:16:41
// Design Name: 
// Module Name: simRAM
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


module simRAM();
    reg clk;
    reg wr_e;
    reg [9:0] addr;
    reg [15:0] wdata;
    wire [15:0] rdata;
    
    RAM ram(
        .clk(clk),
        .wr_e(wr_e),
        .addr(addr),
        .wdata(wdata),
        .rdata(rdata)
    );
    
    initial
    begin
        clk=1;
        
        #50
        wr_e=1;
        addr=0;
        wdata=16'h4745;
        
        #50
        wr_e=1;
        addr=2;
        wdata=16'habcd;
        
        #50
        wr_e=1;
        addr=4;
        wdata=16'hffff;
        
        #50
        wr_e=1;
        addr=6;
        wdata=16'h1234;
        
        #50
        addr=10'bx;
        wdata=16'hx;
        
        #50
        wr_e=0;
        addr=0;
        
        #50
        wr_e=0;
        addr=2;
        
        #50
        wr_e=0;
        addr=4;
        
        #50
        wr_e=0;
        addr=6;
        
        #50
        wr_e=1'bx;
        addr=10'bx;
    end
    
    always #25 clk=~clk;
endmodule





















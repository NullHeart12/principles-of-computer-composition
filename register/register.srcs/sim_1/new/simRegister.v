`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 20:27:17
// Design Name: 
// Module Name: simRegister
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


module simRegister();
    reg clk;
    
    reg we;
    reg [2:0] waddr;
    reg [15:0] wdata;
    
    reg re1;
    reg [2:0] raddr1;
    wire [15:0] rdata1;

    reg re2;
    reg [2:0] raddr2;
    wire [15:0] rdata2;
    
    Register myregs(
        .clk(clk),
        .re1(re1),
        .raddr1(raddr1),
        .rdata1(rdata1),
        .re2(re2),
        .raddr2(raddr2),
        .rdata2(rdata2),        
        .we(we),
        .waddr(waddr),
        .wdata(wdata)
    );
    
    initial
    begin
        clk=1;
        
        we=1;
        re1=1;
        re2=1;
        
        #100
        we=0;
        waddr=3'b000;
        wdata=16'h4745;
        //we=1;
        
        #100
        we=0;
        waddr=3'b001;
        wdata=16'habcd;
        //we=1;
        
        #100
        we=0;
        waddr=3'b010;
        wdata=16'hffff;
        //we=1;
        
        #100
        we=0;
        waddr=3'b011;
        wdata=16'hfedc;        
        //we=1;
        
        #100
        we=1;
        waddr=3'bx;
        wdata=16'hx;
        
        #50
        re1=0;
        re2=0;
        raddr1=3'b000;
        raddr2=3'b001;
        //re1=1;
        //re2=1;
        
        #50
        re1=0;
        re2=0;
        raddr1=3'b010;
        raddr2=3'b011;
        //re1=1;
        //re2=1;
        
        #50
        re1=1;
        re2=1;
        raddr1=3'bx;
        raddr2=3'bx;
                
    end 
    always #50 clk=~clk;   
endmodule




























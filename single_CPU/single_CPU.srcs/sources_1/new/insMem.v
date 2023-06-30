`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/11 16:41:59
// Design Name: 
// Module Name: insMem
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


module insMem( 
    input wire re,//high level is valide
    input wire [7:0] addr,
    output reg [15:0] ins
    );
    
    reg [15:0] mem [255:0];
    
    initial
    begin
        mem[1]<=16'b0000000_000_001_010;
        mem[2]<=16'b0000000_011_100_101;
    end
    
    always @(*)
    begin
        if(re)
        begin
            if(addr<=255)
                ins<=mem[addr];
            else
                ins<=16'hffff;//when the address is invalide,insruction is ffff
        end
        else
            ins<=16'hffff;
    end
    
endmodule













`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/12 20:58:16
// Design Name: 
// Module Name: PC
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


module PC(
    input wire clk,
    input wire rst,
    input wire set,
    input wire [9:0] set_addr,
    output reg[9:0] ins_addr//the size of insMem is 1k*8bits
    );
    
    always @(posedge clk or posedge rst)
    begin
        if(ins_addr==1020||rst)
            ins_addr<=0;
        else 
        begin
            if(set)
                ins_addr<=set_addr;
            else
                ins_addr=ins_addr+4;//instruction memory is addressed by byte,so every time plus 4 unit 
        end
    end
    
endmodule


















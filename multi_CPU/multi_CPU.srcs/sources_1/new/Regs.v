`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/13 07:52:51
// Design Name: 
// Module Name: Regs
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


module Regs(
    input wire we,                   // Write enable signal
    input wire [4:0] waddr,          // Write address
    input wire [31:0] wdata,         // Write data
    
    input wire wre,                  // Write enable signal for read
    input wire [4:0] wraddr,         // Write address for read
    input wire [31:0] wrdata,        // Write data for read
    
    input wire re1,                  // Read enable signal for rdata1
    input wire [4:0] raddr1,         // Read address for rdata1
    output reg [31:0] rdata1,        // Read data 1
    
    input wire re2,                  // Read enable signal for rdata2
    input wire [4:0] raddr2,         // Read address for rdata2
    output reg [31:0] rdata2,        // Read data 2
    
    input wire rbe,                  // Read enable signal for rbdata
    input wire [4:0] rbaddr,         // Read address for rbdata
    output reg [31:0] rbdata,        // Read back data
    
    input wire wle,                  // Write enable signal for write to reg
    input wire [4:0] wladdr,         // Write address for write to reg
    input wire [31:0] wldata,        // Write data for write to reg
    
    input wire rse,                  // Read enable signal for rsdata
    input wire [4:0] rsaddr,         // Read address for rsdata
    output reg [31:0] rsdata,        // Read select data
    
    input wire cmpre1,               // Compare read enable signal for cmprdata1
    input wire cmpre2,               // Compare read enable signal for cmprdata2
    input wire [4:0] cmpraddr1,      // Compare read address for cmprdata1
    input wire [4:0] cmpraddr2,      // Compare read address for cmprdata2
    output reg [31:0] cmprdata1,     // Compare read data 1
    output reg [31:0] cmprdata2      // Compare read data 2
    );
    
    reg [31:0] regs [31:0];    // Array of registers, 32-bit wide
    
    initial
    begin
        // Initialize base registers
        regs[18] <= 32'h00000000;    // 0
        regs[19] <= 32'h00000100;    // 256
        regs[20] <= 32'h00000200;    // 512
        regs[21] <= 32'h00000300;    // 768
        regs[22] <= 32'h00000400;    // 1024
        regs[27] <= -1;              // -1 (all bits set to 1)
        regs[23] <= 256;             // 256
        regs[24] <= 425;             // 425
        regs[31] <= 111;             // 111
        regs[30] <= 111;             // 111
    end
    
    always @(wre or wraddr or wrdata)
    begin
        // Write operation
        if (wre)
            regs[wraddr] <= wrdata;
    end
    
    always @(rse or rsaddr)
    begin
        // Read operation for rsdata
        if (rse)
            rsdata <= regs[rsaddr];
        else
            rsdata <= 32'hffffffff;     // Invalid read data symbol
    end
    
    always @(cmpre1 or cmpre2 or cmpraddr1 or cmpraddr2)
    begin
        // Compare read operation
        if (cmpre1 && cmpre2)
        begin
            cmprdata1 <= regs[cmpraddr1];
            cmprdata2 <= regs[cmpraddr2];
        end
        else
        begin
            cmprdata1 <= 32'hffffffff;   // Invalid read data symbol
            cmprdata2 <= 32'hffffffff;   // Invalid read data symbol
        end
    end
    
    always @(wle or wladdr or wldata)
    begin
        // Write operation to specific register
        if (wle && wladdr <= 31)
        begin
            regs[wladdr] <= wldata;
        end
    end
    
    always @(rbe or rbaddr)
    begin
        // Read operation for rbdata
        if (rbe && rbaddr <= 31)
            rbdata <= regs[rbaddr];
        else
            rbdata <= 32'hffffffff;     // Invalid read data symbol
    end
    
    always @(we or waddr)
    begin
        // Write operation
        if (we && waddr <= 31)
            regs[waddr] <= wdata;
    end
    
    always @(re1 or raddr1)
    begin
        // Read operation for rdata1
        if (re1 && raddr1 <= 31)
            rdata1 <= regs[raddr1];
        else 
            rdata1 <= 32'hffffffff;     // Invalid read data symbol
    end
    
    always @(re2 or raddr2)
    begin
        // Read operation for rdata2
        if (re2 && raddr2 <= 31)
            rdata2 <= regs[raddr2];
        else 
            rdata2 <= 32'hffffffff;     // Invalid read data symbol
    end
    
endmodule



















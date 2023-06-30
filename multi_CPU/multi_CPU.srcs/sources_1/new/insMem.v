`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/12 21:16:22
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
    input wire InsMemEn,
    input wire [9:0] ins_addr,
    output reg [31:0] ins
    );
    
    reg [7:0] mem[1023:0];//the size of insMem is 1k*8bits,instruction memory is addressed by byte
  
//    initial
//    begin
//        //load
//        {mem[7], mem[6], mem[5], mem[4]} <= 32'b000000000000_10010_010_00101_0000011; // base_reg: 18, dir_reg: 5
//        {mem[11], mem[10], mem[9], mem[8]} <= 32'b000010000000_10011_010_00110_0000011; // base_reg: 19, dir_reg: 6, offset: 128
//        {mem[15], mem[14], mem[13], mem[12]} <= 32'b000001000000_10100_010_00111_0000011; // base_reg: 20, dir_reg: 7, offset: 64
//        {mem[19], mem[18], mem[17], mem[16]} <= 32'b000000100000_10101_010_11100_0000011; // base_reg: 21, dir_reg: 28, offset: 32
//        // use r type xor in order to clear the dir reg, dir reg: 7
//        {mem[23], mem[22], mem[21], mem[20]} <= 32'b0000000_00111_00111_100_00111_0110011;
//        // use r type xor to do com with dir reg, dir reg: 28
//        {mem[27], mem[26], mem[25], mem[24]} <= 32'b0000000_11011_11100_100_11100_0110011;
//        // SHR, dir reg: 23
//        {mem[31], mem[30], mem[29], mem[28]} <= 32'b0100000_00001_10111_101_10111_0010011;
//        // rd = (rs << shamt) | (rs >> (32 - shamt))
//        {mem[35], mem[34], mem[33], mem[32]} <= 32'b0000000_00001_11000_001_11001_0010011;
//        {mem[39], mem[38], mem[37], mem[36]} <= 32'b0100000_11111_11000_001_11010_0010011;
//        {mem[43], mem[42], mem[41], mem[40]} <= 32'b0000000_11001_11010_110_11000_0110011;
//        // add 4745, 5474
//        {mem[47], mem[46], mem[45], mem[44]} <= 32'b0000000_00110_00101_000_00101_0110011;
//        // store the result of 4745 + 5474
//        {mem[51], mem[50], mem[49], mem[48]} <= 32'b0000000_10010_00101_010_00000_0100011;
//        // beq
//        {mem[55], mem[54], mem[53], mem[52]} <= 32'b0000000_11111_11110_000_00110_1100011;
//        // jal
//        {mem[67], mem[66], mem[65], mem[64]} <= 32'b0_0000001111_0_00000000_00001_1101111;
//    end
      
    
    initial
    begin
        //load
        {mem[3],mem[2],mem[1],mem[0]}<=32'b000000000000_10010_010_00101_0000011;//base_reg:18,dir_reg:5
        {mem[7],mem[6],mem[5],mem[4]}<=32'b000010000000_10011_010_00110_0000011;//base_reg:19,dir_reg:6,offset:128
        {mem[11],mem[10],mem[9],mem[8]}<=32'b000001000000_10100_010_00111_0000011;//base_reg:20,dir_reg:7,offset:64
        {mem[15],mem[14],mem[13],mem[12]}<=32'b000000100000_10101_010_11100_0000011;//base_reg:21,dir_reg:28,offset:32
        //use r type xor in order to clear the dir reg,dir reg:7
        //{mem[19],mem[18],mem[17],mem[16]}<=32'b0000000_00111_00111_100_11101_0110011;
        {mem[19],mem[18],mem[17],mem[16]}<=32'b0000000_00111_00111_100_00111_0110011;
        //use r type xor to do com with dir reg,dir reg:28
        {mem[23],mem[22],mem[21],mem[20]}<=32'b0000000_11011_11100_100_11100_0110011;
        //SHR,dir reg:23
        {mem[27],mem[26],mem[25],mem[24]}<=32'b0100000_00001_10111_101_10111_0010011;
        // rd = (rs << shamt) | (rs >> (32 - shamt))
        {mem[31],mem[30],mem[29],mem[28]}<=32'b0000000_00001_11000_001_11001_0010011;
        {mem[35],mem[34],mem[33],mem[32]}<=32'b0100000_11111_11000_101_11010_0010011;
        {mem[39],mem[38],mem[37],mem[36]}<=32'b0000000_11001_11010_110_11000_0110011;
        //add 4745,5474
        {mem[43],mem[42],mem[41],mem[40]}<=32'b0000000_00110_00101_000_00101_0110011;
        //store the result of 4745+5474
        {mem[47],mem[46],mem[45],mem[44]}<=32'b0000000_00101_10010_010_00000_0100011;
        //beq
        {mem[51],mem[50],mem[49],mem[48]}<=32'b0000000_11111_11110_000_00110_1100011;
        //jal
        //{mem[63],mem[62],mem[61],mem[60]}<=32'b1_0000001111_0_00000000_00001_1101111;
        {mem[63],mem[62],mem[61],mem[60]}<=32'b1_1111110001_0_00000000_00001_1101111;
        //stop
        {mem[123],mem[122],mem[121],mem[120]}<=32'hffffffff;
    end
    
    
    always @(*)
    begin
        if(InsMemEn&&ins_addr<=1023)
        begin
            //little endian
            ins[7:0]<=mem[ins_addr];
            ins[15:8]<=mem[ins_addr+1];
            ins[23:16]<=mem[ins_addr+2];
            ins[31:24]<=mem[ins_addr+3];
        end
        else
            ins<=32'h00000000;//the symbol of invalide instruction
    end
    
endmodule












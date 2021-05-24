`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:08 04/19/2020 
// Design Name: 
// Module Name:    Part2_4bit_counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Part2_4bit_counter(
    input reset,
    input clk,
    output reg [3:0] Q
    );

wire w1, w2, w3, w4, w5, w6;

assign w6 = Q[0] & Q[1];
assign w1 = ~Q[0];
assign w2 = Q[1] ^ Q[0];
assign w3 = w6 ^ Q[2];
assign w5 = w6 & Q[2];
assign w4 = Q[3] ^ w5;

D_flipflop D1(.reset(reset), .clk(clk), .data(w1), .Q(Q[0]));
D_flipflop D2(.reset(reset), .clk(clk), .data(w2), .Q(Q[1]));
D_flipflop D3(.reset(reset), .clk(clk), .data(w3), .Q(Q[2]));
D_flipflop D4(.reset(reset), .clk(clk), .data(w4), .Q(Q[3]));

endmodule

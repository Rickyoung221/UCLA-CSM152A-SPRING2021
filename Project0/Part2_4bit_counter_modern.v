`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:47:19 04/19/2020 
// Design Name: 
// Module Name:    Part2_4bit_counter_modern 
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
module Part2_4bit_counter_modern(
    input clk,
    output reg [3:0]a,
    input rst
    );

	 
	 always @ (posedge clk)
		if (rst)
			a <= 4'b0000;
		else
			a <= a + 1'b1;

endmodule

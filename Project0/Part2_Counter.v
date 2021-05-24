`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:36 04/19/2020 
// Design Name: 
// Module Name:    Part2_counter 
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
module Part2_counter (
  output reg [3:0] count,
  input clk,
  input reset
);

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			count <= 4'b0000;
		end
		else begin
			count[0] <= ~count[0];
			count[1] <= count[0] ^ count[1];
			count[2] <= (count[0] & count[1]) ^ count[2];
			count[3] <= ((count[0] & count[1]) & count[2]) ^ count[3];
		end
	end
  
endmodule

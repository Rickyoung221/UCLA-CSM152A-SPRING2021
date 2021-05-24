`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:06:13 04/20/2020 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
    output reg clk_1khz,
	 input clk_in,
	 input rst,
    output reg [15:0] count
    );

initial 
	begin
		clk_1khz = 1'b0;
		count = 16'b0;
	end 
	
	//while the counter arrive to the constant, it resets and flip the clk_1khz
	always @ (posedge clk_in) begin
		count <= count + 1'b1;
		if (count == 5000) begin						//10khz -> 5000 clock cycles for clk_1hz to flip its value.
			clk_1khz <= ~clk_1khz;
			count <= 16'b0;
		end
	end


endmodule

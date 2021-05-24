`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:19:00 04/20/2020
// Design Name:   clock_divider
// Module Name:   /home/ise/152A/Project1/clock_divider_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_divider_tb;

	// Inputs
	reg clk_in;
	reg rst;
	// Outputs
	wire clk_1khz;
	wire [12:0] count;

	
	// Instantiate the Unit Under Test (UUT)
	clock_divider uut (
		.clk_1khz(clk_1khz), 
		.clk_in(clk_in), 
		.rst(rst), 
		.count(count)
	);
	
	//Creat input 10khz 
	always #50000 clk_in=~clk_in;
	initial begin
		// Initialize Inputs
		clk_in <= 0;
		rst<= 0;

		// Wait 100 ns for global reset to finish
		#1000000 $finish;
	end
	
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:05:46 04/19/2020
// Design Name:   Part2_counter
// Module Name:   /home/ise/152A/Project1/counter_TB.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Part2_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_TB;
	// Inputs
	reg clk;
	reg reset;
	// Outputs
	wire [3:0] count;
	// Instantiate the Unit Under Test (UUT)
	Part2_counter uut (
		.clk(clk), 
		.count(count), 
		.reset(reset)
	);
	always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		clk <= 0;
		reset <= 0;
		#20;
		reset <= 1;
		#50 reset <= 0;
		#60 reset <= 1;
		#40 reset <= 0;
		// Wait 100 ns for global reset to finish
		#160 $finish;
	end
      
endmodule


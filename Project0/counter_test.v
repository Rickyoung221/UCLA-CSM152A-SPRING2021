`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:25:54 04/19/2020
// Design Name:   Part2_4bit_counter_modern
// Module Name:   /home/ise/152A/Project1/counter_test.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Part2_4bit_counter_modern
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_test;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] a;

	// Instantiate the Unit Under Test (UUT)
	Part2_4bit_counter_modern uut (
		.clk(clk), 
		.a(a), 
		.rst(rst)
	);

	//Create input clock 10khz 
	always #5 clk=~clk;      //Toggle clock every 5 ticks
	
	initial begin
		// Initialize Inputs
		clk <= 0;
		rst <= 0;
		#20;
		rst <= 1;
		#50 rst <= 0;
		#60 rst <= 1;
		#40 rst <= 0;
		// Wait 100 ns for global reset to finish
		#160 $finish;
        
		// Add stimulus here

	end
      
endmodule


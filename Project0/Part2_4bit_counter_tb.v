`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:15:15 04/19/2020
// Design Name:   Part2_4bit_counter
// Module Name:   /home/ise/152A/Project1/Part2_4bit_counter_tb.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Part2_4bit_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Part2_4bit_counter_tb;

	// Inputs
	reg [3:0] reset;
	reg clk;
	wire [3:0] Q;

	// Instantiate the Unit Under Test (UUT)
	Part2_4bit_counter uut (
		.reset(reset), 
		.clk(clk), 
		.Q(Q)
	);


	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		

		#10 reset = 1;
		#20 reset = 0;
		// Wait 100 ns for global reset to finish
		#100 $finish;
        
		// Add stimulus here
	end

	end
endmodule


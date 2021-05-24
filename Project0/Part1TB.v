`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:22:45 04/19/2020
// Design Name:   Part1
// Module Name:   /home/ise/152A/Project1/Part1TB.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Part1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Part1TB;

	// Inputs
	reg [4:0] sw;


	// Outputs
	wire LED;

	// Instantiate the Unit Under Test (UUT)
	Part1 uut (
		.sw(sw), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		sw = 5'b0;
	end
	
	always begin
		#5 sw = sw + 1'b1;
	end
	
	initial
		// Wait 100 ns for global reset to finish
		#100 $finish;
        
		// Add stimulus here
      
endmodule


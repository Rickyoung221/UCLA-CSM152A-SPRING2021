`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  WEIKENG YANG
//
// Create Date:   22:16:50 04/16/2021
// Design Name:   FPCVT
// Module Name:   /home/ise/152A/Project1/testbench_405346443.v
// Project Name:  Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FPCVT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_405346443;

	// Inputs
	reg [12:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [4:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//Case#1 V = 0
		D = 13'b0_0000_0000_0000;
		#20;	
		if (S == 1'b0 && E == 3'b000 && F == 5'b00000)
				$display("Test case#1 Passed. ");
		else
				$display("Test case#1 Failed.");
				
		//Case#2 1
		D = 13'b0_0000_0000_0001;
		#20;
		if (S == 1'b0 && E == 3'b000 && F == 5'b00001)
				$display("Test case#2 Passed. ");
		else
				$display("Test case#2 Failed.");
				
		//Case#3 -1
		D = 13'b1_1111_1111_1111;
		#20;	
		if (S == 1'b1 && E == 3'b000 && F == 5'b00001)
				$display("Test case#3 Passed. ");
		else
				$display("Test case#3 Failed.");
				
		//Case#4 2730
		D = 13'b0_1010_1010_1010;
		#20;	
		if (S == 1'b0 && E == 3'b111 && F == 5'b10101)
				$display("Test case#4 Passed. ");
		else
				$display("Test case#4 Failed.");
					
		//Case#5 15
		D = 13'b0_0000_0000_1111;
		#20;	
		if (S == 1'b0 && E == 3'b000 && F == 5'b01111)
				$display("Test case#5 Passed. ");
		else
				$display("Test case#5 Failed.");
				
		//Case#6 108
		D = 13'b0_0000_0110_1100;
		#20;
		if (S == 1'b0 && E == 3'b010 && F == 5'b11011)
				$display("Test case#6 Passed. ");
		else
				$display("Test case#6 Failed.");

		//Case#7 109
		D = 13'b0_0000_0110_1101;
		#20;	
		if (S == 1'b0 && E == 3'b010 && F == 5'b11011)
				$display("Test case#7 Passed. ");
		else
				$display("Test case#7 Failed.");

		//Case#8 110
		D = 13'b0_0000_0110_1110;
		#20;	
		if (S == 1'b0 && E == 3'b010 && F == 5'b11100)
				$display("Test case#8 Passed. ");
		else
				$display("Test case#8 Failed.");


		//Case#9 111
		D = 13'b0_0000_0110_1111;
		#20;
		if (S == 1'b0 && E == 3'b010 && F == 5'b11100)
				$display("Test case#9 Passed. ");
		else
				$display("Test case#9 Failed.");


		//Case#10 -4096
		D = 13'b1_0000_0000_0000;
		#20;
		if (S == 1'b1 && E == 3'b111 && F == 5'b11111)
				$display("Test case#10 Passed. ");
		else
				$display("Test case#10 Failed.");


		//Case#11 4095
		D = 13'b0_1111_1111_1111;
		#20;
		if (S == 1'b0 && E == 3'b111 && F == 5'b11111)
				$display("Test case#11 Passed. ");
		else
				$display("Test case#11 Failed.");

		//Case#12 -4095
		D = 13'b1_0000_0000_0001;
		#20;
		if (S == 1'b1 && E == 3'b111 && F == 5'b11111)
				$display("Test case#12 Passed. ");
		else
				$display("Test case#12 Failed.");
		
		//Case#13 
		D = 13'b0_0000_1111_1101;
		#20;
		if (S == 1'b0 && E == 3'b100 && F == 5'b10000)
				$display("Test case#13 Passed. ");
		else
				$display("Test case#13 Failed.");

		//Case#14 422
		D = 13'b0_0001_1010_0110;
		#20;
		if (S == 1'b0 && E == 3'b100 && F == 5'b11010)
				$display("Test case#14 Passed. ");
		else
				$display("Test case#14 Failed.");
		
		//Case#15 -422
		D = 13'b1_1110_0101_1010;
		#20;
		if (S == 1'b1 && E == 3'b100 && F == 5'b11010)
				$display("Test case#15 Passed. ");
		else
				$display("Test case#15 Failed.");		

	end
      
endmodule


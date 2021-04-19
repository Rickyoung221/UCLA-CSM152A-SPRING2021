`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Weikeng Yang
// 
// Create Date:    22:08:31 04/16/2021 
// Design Name: 
// Module Name:    FPCVT 
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

module FPCVT(D, S, E, F);
	 input wire [12:0] D; //Input 13-bit number in Two's complement representation
	 output reg S; // Sign bit of the FLoating Point Representation
	 output reg [2:0] E; //3-bit exponent of the floating point representation
	 output reg [4:0] F; //5-bit significand 
	 
	 reg [12:0] abs_value; //Register to manipulate bits
	 reg sixth_bit; // Register to store the 6th bit following the last leading 0
	 
	 //assign S = D[12]; //The Most significant bit
	 
	 always @(D) begin
			// Frist Block. Two's complement to sign-magnitude
			S = D[12];
			if (D[12] == 1'b0) //MST is 0, positive
				abs_value = D[12:0];
			else if (D[12:0] == 13'b1_0000_0000_0000) //handle the case for -4096
				abs_value = 13'b1_1111_1111_1111;
			else	// MST is 1, negative-> Invert all bits and adding 1
				begin
					abs_value = ~D[12:0] + 1'b1;
				end
		
		// Second BLOCK: LINEAR TO FLOATING POINT CONVERSION
			//default:
			E = 3'b111;
			F = 5'b1_1111;
			sixth_bit = 1'b0;
			if (abs_value[12:5] == 8'b0000_0000) 
				begin
					E[2:0] = 3'b000;
					F[4:0] = abs_value[4:0];
					sixth_bit = 1'b0;
				end
			else if (abs_value[12:6] == 7'b000_0000)
				begin
					E[2:0] = 3'b001;
					F[4:0] = abs_value[5:1];
					sixth_bit = abs_value[0];
				end
			else if (abs_value[12:7] == 6'b00_0000)
				begin
					E[2:0] = 3'b010;
					F[4:0] = abs_value[6:2];
					sixth_bit = abs_value[1];
				end
			else if (abs_value[12:8] == 5'b0_0000)
				begin
					E[2:0] = 3'b011;
					F[4:0] = abs_value[7:3];
					sixth_bit = abs_value[2];
				end
			else if (abs_value[12:9] == 4'b0000)
				begin
					E[2:0] = 3'b100;
					F[4:0] = abs_value[8:4];
					sixth_bit = abs_value[3];
				end
			else if (abs_value[12:10] == 3'b000)
				begin
					E[2:0] = 3'b101;
					F[4:0] = abs_value[9:5];
					sixth_bit = abs_value[4];
				end
			else if (abs_value[12:11] == 2'b00)
				begin
					E[2:0] = 3'b110;
					F[4:0] = abs_value[10:6];
					sixth_bit = abs_value[5];
				end
			else if (abs_value[12] == 1'b0)
				begin
					E[2:0] = 3'b111;
					F[4:0] = abs_value[11:7];
					sixth_bit = abs_value[6];
				end
		
		
		// THIRD BLOCK: ROUNDING OF THE FLOATING POINT REPRESENTATION
			if (sixth_bit == 1'b1) //sixth bit is 1 -> round up
					if (F == 5'b1_1111)//overflow, shift the significand right one bit and increase the exponent E by 1
							if (E == 3'b111) //exponent overflow
									F = 5'b1_1111;
							else //no overflow for exponent
								begin
									F = 5'b1_0000; //shift right
									E = E + 1'b1; //Exponent add 1
								end					
					else// add 1 to significand to round up
							begin
								F = F + 1'b1;
							end
			else //Round down
					begin
						F = F;
						E = E;
					end
		
		end
		//always block end
endmodule
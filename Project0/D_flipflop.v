`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:18:35 04/19/2020 
// Design Name: 
// Module Name:    D_flipflop 
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
module D_flipflop(
    input reset, 		//Reset input
    input clk,			//Clock input
    input data,		//Data input
    output reg Q	   //Q output
    );

always @(posedge clk) begin
	if (reset == 1'b1) 
		Q <= 1'b0;
	else
		Q <= data;
end

endmodule
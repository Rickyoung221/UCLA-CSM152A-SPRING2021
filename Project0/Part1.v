`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA CS152A
// Engineer: Weikeng Yang
// 
// Create Date:    03:15:21 04/19/2020 
// Design Name: 
// Module Name:    Part1 
// Project Name: Project1 
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
module Part1(
	 input [4:0] sw,
    output reg LED
    );

// Declare the 8 inputs for 8:1 mux from the gates
wire not_put;
wire buffer_out;
wire xnor_out;
wire xor_out;
wire or_out;
wire nor_out;
wire and_out;
wire nand_out;
// Declare wire for mux and selection
wire [7:0] MUX;
wire [2:0] SelectIn;

// Generate the outputs of the 8 gates 
assign not_put = ~sw[0];
assign buffer_out = sw[0];
assign xnor_out = sw[0] ~^ sw[1];
assign xor_out = sw[0] ^ sw[1];
assign or_out = sw[0] | sw[1];
assign nor_out = ~(sw[0] | sw[1]);
assign and_out = sw[0] & sw[1];
assign nand_out = ~(sw[0] & sw[1]);
// Generate input for mux
assign MUX = {
not_put,
buffer_out,
xnor_out,
xor_out,
or_out,
nor_out,
and_out,
nand_out};
assign SelectIn = sw[4:2];

// Output, use block statement
always @(MUX, SelectIn) begin
	LED = MUX[SelectIn];
end

endmodule

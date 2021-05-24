`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA
// Engineer: Weikeng Yang
// 
// Create Date:    22:55:53 04/25/2021 
// Design Name: 
// Module Name:    clock_gen 
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
module clock_gen(
input clk_in,
input rst,
output clk_div_2,
output clk_div_4,
output clk_div_8,
output clk_div_16,
output clk_div_32,
output clk_div_26,
output clk_div_3,
output clk_pos,
output clk_neg,
output clk_div_5,
output clk_div,
output [7:0] toggle_counter
);
clock_div_two task1(
	.clk_in (clk_in),
	.rst (rst),
	.clk_div_2(clk_div_2),
	.clk_div_4(clk_div_4),
	.clk_div_8(clk_div_8),
	.clk_div_16(clk_div_16)
);
clock_div_thirty_two task2 (
	.clk_in(clk_in),
	.rst(rst),
	.clk_div_32(clk_div_32)
);
clock_div_twenty_six task3(
	.clk_in (clk_in),
	.rst (rst),
	.clk_div_26 (clk_div_26)
);
clock_div_three task456(.clk_in(clk_in),
	.rst(rst),
	.clk_div_3(clk_div_3),
	.clk_pos(clk_pos),
	.clk_neg(clk_neg)
);
clock_div_five task7(
	.clk_in (clk_in),
	.rst (rst),
	.clk_div_5 (clk_div_5)
);
clock_pulse task8(
	.clk_in(clk_in),
	.rst(rst),
	.clk_div(clk_div)
);
clock_strobe task9(
	.clk_in (clk_in),
	.rst (rst),
	.toggle_counter (toggle_counter)
);
endmodule

// task 1
module clock_div_two(clk_in, rst, clk_div_2, clk_div_4,clk_div_8, clk_div_16);
input clk_in, rst;
output clk_div_2, clk_div_4, clk_div_8, clk_div_16;

reg	[3:0]	a;
always@(posedge clk_in )
	begin
		if(rst)
			a <= 4'b0000;
		else 
			a <= a + 1'b1;
	end

assign clk_div_2 = a[0];
assign clk_div_4 = a[1];
assign clk_div_8 = a[2];
assign clk_div_16 = a[3];
endmodule

// task 2
module clock_div_thirty_two(clk_in, rst, clk_div_32);
input clk_in, rst;
output reg clk_div_32;

reg	[3:0]	a;
always@(posedge clk_in )
begin
	if(rst)
		begin
			a <= 4'b0000;
			clk_div_32<=1'b0;
		end
	else 
		begin
			a <= a + 1'b1;
			if(a == 4'b1111)  // when the counter is 15 we flip the divide by 32 clock 
				clk_div_32 <= ~clk_div_32;   
	end
end

endmodule
// task 3
module clock_div_twenty_six(clk_in, rst, clk_div_26);
input clk_in, rst;
output reg clk_div_26;

reg	[3:0]	a;
always@(posedge clk_in )
begin
	if(rst)
		begin
			a <= 4'b0000;
			clk_div_26<=1'b0;
		end
	else 
		begin
			if(a == 4'b1100)  // when the counter is 12 we flip the divide by 26 clock 
				begin
					clk_div_26 <= ~clk_div_26;  
					a <= 0;
				end
			else
				a <= a + 1'b1;
		end
end
endmodule


// task 4, 5, 6
module clock_div_three(clk_in, rst, clk_div_3, clk_pos,clk_neg);
input clk_in, rst;
output clk_div_3;
output reg clk_pos, clk_neg;

reg	[1:0]	a;
always@(posedge clk_in) //positive 
begin
	if(rst)
		begin
			a <= 2'b00;
			clk_pos <= 1'b0;
		end
	else if(a == 2'b01)
		begin
			clk_pos<= ~clk_pos;
			a <= a + 1'b1;
		end
	else if(a == 2'b10)   //counter to 2'b10 ,and next to 2'b00
		begin
			clk_pos<= ~clk_pos;
			a <= 2'b00;
		end
	else
		begin
			a <= a + 1'b1;
			clk_pos <= clk_pos;
		end
end


reg	[1:0]	b;
always@(negedge clk_in) //negedge
	begin
		if(rst)
			begin
				b <= 2'b00;
				clk_neg <= 1'b0;
		end
		else if(b == 2'b01)
			begin
				clk_neg<= ~clk_neg;
				b <= b + 1'b1;
			end
		else if(b == 2'b10)   //counter to 2'b10 ,and next to 2'b00
			begin
				clk_neg<= ~clk_neg;
				b <= 2'b00;
			end
		else
			begin
				b <= b + 1'b1;
				clk_neg <= clk_neg;
			end
end


assign clk_div_3 = clk_neg | clk_pos;  //logic or 

endmodule


// task 7
module clock_div_five(clk_in, rst, clk_div_5);
input clk_in, rst;
output clk_div_5;

reg 			clk_pos;
reg	[2:0]	a;

always@(posedge clk_in)  //posedge
begin
	if(rst)
		begin
			clk_pos <= 0;
			a <= 3'b000;
		end
	else if(a == 3'b010)
		begin
			clk_pos <= ~clk_pos;
			a <= a + 1'b1;
		end
	else if(a == 3'b100)  //counter to 3'b100 ,and next to 3'b000
		begin
			clk_pos <= ~clk_pos;
			a <= 3'b000;
		end
	else
		begin
			clk_pos <= clk_pos;
			a <= a + 1'b1;
		end
end

reg 			clk_neg;
reg	[2:0]	b;

always@(negedge clk_in)  //negedge
	begin
		if(rst)
			begin
				clk_neg <= 0;
				b <= 3'b000;
			end
		else if(b == 3'b010)
			begin
				clk_neg <= ~clk_neg;
				b <= b + 1'b1;
			end
		else if(b == 3'b100)  //counter to 3'b100 ,and next to 3'b000
			begin
				clk_neg <= ~clk_neg;
				b <= 3'b000;
			end
	else
			begin
				clk_neg <= clk_neg;
				b <= b + 1'b1;
			end
	end

assign clk_div_5 = clk_neg | clk_pos;
endmodule


// task 8
module clock_pulse(clk_in, rst, clk_div);
input clk_in, rst;
output reg clk_div;

reg			clk_div_100;
reg	[6:0]	a;

always@(posedge clk_in)
	begin
		if(rst)
			begin
				a <= 7'd0;
				clk_div_100 <= 1'b0;
			end
		else if(a == 7'd98)
				begin
					a <= a + 1'b1;
					clk_div_100 <= ~clk_div_100;
				end
		else if(a == 7'd99) //counter to 7'd99 ,and next to 7'd0
				begin
					a <= 7'd0;
					clk_div_100 <= ~clk_div_100;
				end
		else
				begin
					a <= a + 1'b1;
					clk_div_100 <= clk_div_100;
				end
end

always@(posedge clk_in)
	begin
		if(rst)
			begin
				clk_div <= 0;
			end
		else if(clk_div_100)  
			begin
				clk_div <= ~clk_div;  //clk_div  500Khz
			end
		else
			clk_div <= clk_div;
	end

endmodule
// task 9
module clock_strobe(clk_in, rst, toggle_counter);
input clk_in, rst;
output reg [7:0] toggle_counter;
reg strobe;
reg [1:0] a;
always @ (posedge clk_in) 
begin
	if (rst) 
		begin
			a <= 4'b00;
			strobe <= 1'b0;
			toggle_counter <= 8'b0000_0000;
		end
	else 
		begin
			a <= a + 1'b1;
			strobe <= a[1];		
			if (strobe) 
				begin					
					toggle_counter <= toggle_counter - 3'b101;// subtract by 5
					strobe <= ~strobe;
				end
			else
				toggle_counter <= toggle_counter + 2'b11;	//  add 3
		end
end
endmodule



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA
// Engineer: Weikeng Yang
// 
// Create Date: 2021/05/17 14:05:14
// Design Name: 
// Module Name: vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
 

cccmodule vending_machine(
input			CLK,
input			RESET,
input			RELOAD,
input			CARD_IN,
input	[2:0]	ITEM_CODE,
input			KEY_PRESS,
input			VALID_TRN,

output	reg		VEND,
output	reg		INVALID_SEL,
output	reg[2:0]	COST,
output	reg		FALID_TRAN
);

//states
parameter IDEL = 4'b0000,
		RELOADING = 4'b0001,
		AWAIT_KEY1 = 4'B0010,	
		AWAIT_KEY2 = 4'b0011, 
		INVALID_SELECTION = 4'b0100,
		AWAIT_VALID_TRAN = 4'b0101,
		FAILURE = 4'b0110,
		VENDING = 4'b0111;
initial
begin
current_state = IDEL;
end

reg [3:0] current_state;
reg [3:0] code1;
reg [3:0] code2;

reg	[2:0]	time_cnt;

reg	[3:0]	stored_10_left;
reg	[3:0]	stored_11_left;
reg	[3:0]	stored_12_left;
reg	[3:0]	stored_13_left;
reg	[3:0]	stored_14_left;
reg	[3:0]	stored_20_left;
reg	[3:0]	stored_21_left;
reg	[3:0]	stored_22_left;
reg	[3:0]	stored_23_left;
reg	[3:0]	stored_24_left;

always@(posedge CLK)
	begin
		if(RESET)
			begin
				stored_10_left <=0;
				stored_11_left <=0;
				stored_12_left <=0;
				stored_13_left <=0;
				stored_14_left <=0;
				stored_20_left <=0;
				stored_21_left <=0;
				stored_22_left <=0;
				stored_23_left <=0;
				stored_24_left <=0;
				code1 <=0;
				code2 <=0;
				VEND <= 0;
				INVALID_SEL<=0;
				COST <= 0;
				FALID_TRAN <=0;
				time_cnt <= 0;
				current_state <= IDEL;
			end
else
case(current_state)
	IDEL :
		begin
			code1 <=0;
			code2 <=0;
			VEND <= 0;
			INVALID_SEL<=0;
			COST <= 0;
			FALID_TRAN <=0;
			time_cnt <= 0;
			if(CARD_IN)
				current_state <= AWAIT_KEY1;
			else if(RELOAD)
				begin
					current_state <= RELOADING;
				end
		end
		
	 RELOADING:
		begin
			current_state <= IDEL;
			stored_10_left <=10;
			stored_11_left <=10;
			stored_12_left <=10;
			stored_13_left <=10;
			stored_14_left <=10;
			stored_20_left <=10;
			stored_21_left <=10;
			stored_22_left <=10;
			stored_23_left <=10;
			stored_24_left <=10;
		end
		
	AWAIT_KEY1:
		begin
			if(time_cnt == 4)
				begin
					time_cnt <=0;
					current_state <= IDEL;
				end
			else if(KEY_PRESS)
				begin
					time_cnt <=0;
					code1 <= ITEM_CODE;
					current_state <= AWAIT_KEY2;
				end
			else
				time_cnt <= time_cnt + 1'b1;
		end
		
	AWAIT_KEY2:
		begin
		if(time_cnt == 4)
			begin
				time_cnt <=0;
				current_state <= IDEL;
				INVALID_SEL <=1;
			end
		else if(KEY_PRESS)
			begin
			time_cnt <=0;
			if(code1==4'd1 && ITEM_CODE == 4'd0 && (stored_10_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 2;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd1 && ITEM_CODE == 4'd1 && (stored_11_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 2;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd1 && ITEM_CODE == 4'd2 && (stored_12_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 2;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd1 && ITEM_CODE == 4'd3 && (stored_13_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 2;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd1 && ITEM_CODE == 4'd4 && (stored_14_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 2;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd2 && ITEM_CODE == 4'd0 && (stored_20_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 5;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd2 && ITEM_CODE == 4'd1 && (stored_21_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 5;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd2 && ITEM_CODE == 4'd2 && (stored_22_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 5;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd2 && ITEM_CODE == 4'd3 && (stored_23_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 5;
					current_state <= AWAIT_VALID_TRAN;
				end
			else if(code1==4'd2 && ITEM_CODE == 4'd4 && (stored_24_left > 0))
				begin
					code2 <=ITEM_CODE;
					COST <= 5;
					current_state <= AWAIT_VALID_TRAN;
				end
			else
				begin
				INVALID_SEL <=1;
				current_state <= INVALID_SELECTION;
				end
			end
		else
			time_cnt <= time_cnt + 1'b1;
		end
		
	INVALID_SELECTION:
		begin
			INVALID_SEL <=0;
			current_state <= IDEL;	
		end
		
	AWAIT_VALID_TRAN:
		begin
			if(time_cnt == 4)
				begin
					time_cnt <=0;
					current_state <= FAILURE;
					FALID_TRAN <=1;
				end
			else if(VALID_TRN)
				begin
					time_cnt <=0;
					current_state <= VENDING;
					VEND <= 1;
				end
			else
				time_cnt <= time_cnt + 1'b1;
		end
		
	FAILURE:
		begin
			FALID_TRAN <=0;
			current_state <= IDEL;
		end
		
	VENDING:
		begin
			VEND <= 0;
			current_state <= IDEL;
			if(code1==4'd1 && code2 == 4'd0 && (stored_10_left > 0))
				begin
					stored_10_left <= stored_10_left -1'b1;
				end
			else if(code1==4'd1 && code2 == 4'd1 && (stored_11_left > 0))
				begin
					stored_11_left <= stored_11_left -1'b1;
				end
			else if(code1==4'd1 && code2 == 4'd2 && (stored_12_left > 0))
				begin
					stored_12_left <= stored_12_left -1'b1;
				end
			else if(code1==4'd1 && code2 == 4'd3 && (stored_13_left > 0))
				begin
					stored_13_left <= stored_13_left -1'b1;
				end
			else if(code1==4'd1 && code2 == 4'd4 && (stored_14_left > 0))
				begin
					stored_14_left <= stored_14_left -1'b1;
				end
			else if(code1==4'd2 && code2 == 4'd0 && (stored_20_left > 0))
				begin
					stored_20_left <= stored_20_left -1'b1;
				end
			else if(code1==4'd2 && code2 == 4'd1 && (stored_21_left > 0))
				begin
					stored_21_left <= stored_21_left -1'b1;
				end
			else if(code1==4'd2 && code2 == 4'd2 && (stored_22_left > 0))
				begin
					stored_22_left <= stored_22_left -1'b1;
				end
			else if(code1==4'd2 && code2 == 4'd3 && (stored_23_left > 0))
				begin
					stored_23_left <= stored_23_left -1'b1;
				end
			else if(code1==4'd2 && code2 == 4'd4 && (stored_24_left > 0))
				begin
					stored_24_left <= stored_24_left -1'b1;
				end
		end
endcase
end	 

endmodule


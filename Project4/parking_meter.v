`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA
// Engineer: Weikeng Yang
// 
// Create Date: 2021/06/06 15:28:00
// Design Name: 
// Module Name: parking_meter
// Project Name: project4
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


module parking_meter(
input		clk,	//100hz
input		rst,
input		rst1,
input		rst2,

input		add1,
input		add2,
input		add3,
input		add4,

output	[3:0]	val1,		//BCD
output	[3:0]	val2,       //BCD
output	[3:0]	val3,       //BCD
output	[3:0]	val4,       //BCD

output	reg[6:0]	led_seg,	//SEG
output			a1,a2,a3,a4
    );
	
	
parameter idle  = 2'b00,low_180_s = 2'b01,grater_180 = 2'b10;	

reg		[1:0]	state = 2'b00;	

reg	[13:0]		time_counter;



reg	[6:0]		time_1s;
wire	key_en = rst2 | rst1 | add4 | add3 | add2 |add1;


always@(posedge clk )
begin
if(rst)
	begin
	state <= idle;
	end
else if(time_counter ==0)
	state <= idle;
else if(time_counter<180)
	state <= low_180_s;
else
	state <= grater_180;
end



always@(posedge clk )	
begin
if(rst)
	begin
	time_counter <= 14'd0;
	time_1s <= 0;
	end
else if(key_en)
	begin
		time_1s <= 0;
		if(rst1)
			time_counter <= 16;
		else if(rst2)
			time_counter <= 150;
		else if(add4)
			begin
			if(time_counter <= 14'd9699)
				time_counter <= time_counter + 300;
			else	
				time_counter <= 9999;
			end
		else if(add3)
			begin
			if(time_counter <= 14'd9819)
				time_counter <= time_counter + 180;
			else	
				time_counter <= 9999;
			end
		else if(add2)
			begin
			if(time_counter <= 14'd9879)
				time_counter <= time_counter + 120;
			else	
				time_counter <= 9999;
			end
		else if(add1)
			begin
			if(time_counter <= 14'd9939)
				time_counter <= time_counter + 60;
			else	
				time_counter <= 9999;
			end
	end
else 
	begin
	if(time_1s == 99)
		begin
		time_1s <=0;
		if(time_counter !=0)
			time_counter <= time_counter - 1;
		else
			time_counter <= 0;
		end
	else
		time_1s <= time_1s + 1;

	end
end
reg				seg_disp_en=1;	
always@(posedge clk )
begin
if(state == idle)
	begin
	if(time_1s == 99)
		begin
		seg_disp_en <= 0;
		end
	else if(time_1s == 49)
		begin
		seg_disp_en <= 1;
		end
	end
else if(state == low_180_s)
	begin
	if(time_1s == 1)
		begin
		if(time_counter[0])
			seg_disp_en <= 0;
		else
			seg_disp_en <= 1;
		end
	end
else if(state == grater_180)
	begin
	seg_disp_en <= 1;
	end
end
wire [3:0]ones 		;
wire [3:0]tens 	    ;
wire [3:0]hundreds  ;
wire [3:0]thousands ;
assign ones 	=  time_counter% 10;
assign tens 	= (time_counter/ 10) % 10;
assign hundreds = (time_counter/ 100) % 10;
assign thousands= (time_counter/ 1000) % 10;	

assign val1=ones 	  ;
assign val2=tens 	  ;
assign val3=hundreds  ;
assign val4=thousands ;
	
//seg display
reg	[1:0]	sen_num =0;
reg	[3:0]	an = 4'b0;
always@(posedge clk )
begin
sen_num <= sen_num + 1;
if(seg_disp_en)
	begin
	case(sen_num)
		0:
			begin
			an <= 4'b0111;
			led_seg <= seg(thousands);
			end
		1:
			begin
			an <= 4'b1011;
			led_seg <= seg(hundreds);
			end
		2:
			begin
			an <= 4'b1101;
			led_seg <= seg(tens);
			
			end
		3:
			begin
			an <= 4'b1110;
			led_seg <= seg(ones);
			
			end
	endcase
	end
else
	begin
	an <= 4'hf;
	
	end
end


assign {a4,a3,a2,a1} = an;

	
    function [6:0] seg (input [3:0] digit);
    begin
		
        case (digit)
            1: seg = 7'b1001111;
            2: seg = 7'b0010010;
            3: seg = 7'b0000110;
            4: seg = 7'b1001100;
            5: seg = 7'b0100100;
            6: seg = 7'b0100000;
            7: seg = 7'b0001111;
            8: seg = 7'b0000000;
            9: seg = 7'b0000100;
            default: seg = 7'b0000001; 
        endcase
    end 
    endfunction	
	
endmodule































	
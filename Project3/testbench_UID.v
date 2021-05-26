`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA
// Engineer: Weikeng
// 
// Create Date: 2021/05/19 16:48:16
// Design Name: 
// Module Name: testbench_405346443
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


cmodule testbench_405346443(
    );
reg			CLK			;
reg			RESET		;
reg			RELOAD		;
reg			CARD_IN		;
reg	[2:0]	ITEM_CODE	;
reg			KEY_PRESS	;
reg			VALID_TRN	;

wire		VEND;
wire		INVALID_SEL;
wire[2:0]	COST;
wire		FALID_TRAN	;
	
always #5 	CLK = ~CLK;
vending_machine i1(
.CLK		(CLK		),
.RESET		(RESET	),
.RELOAD		(RELOAD	),
.CARD_IN	(CARD_IN	),
.ITEM_CODE	(ITEM_CODE	),
.KEY_PRESS	(KEY_PRESS	),
.VALID_TRN	(VALID_TRN	),
.VEND		(VEND		),
.INVALID_SEL(INVALID_SEL),
.	COST	(	COST	),
.FALID_TRAN (FALID_TRAN )
    );	
	
	
initial
begin
RESET =0;
RELOAD=0;
CARD_IN=0;
ITEM_CODE=0;
KEY_PRESS=0;
VALID_TRN=0;
CLK = 0;
#100;

//Reset 
RESET = 1;// initialize with reset
#10;
RESET = 0;

//Snack stock is empty
#100;
CARD_IN = 1;// card is inserted
#10;
CARD_IN =0;
#10;
KEY_PRESS =1;// key pressed and first code entered
ITEM_CODE=1;
#10;
KEY_PRESS =0;
#10
KEY_PRESS =1; // key second  pressed
ITEM_CODE= 1;
#10;
KEY_PRESS =0;
#100;


//Reload

#100;
RELOAD =1;// reload machine
#10;
RELOAD =0;


//Timeout after no keypress in AWAIT_KEY_1 state
#100;
CARD_IN = 1;// card is inserted
#10;
CARD_IN =0;
#100;

//Timeout after no keypress in AWAIT_KEY_2 state
CARD_IN = 1;// card is inserted
#10;
CARD_IN =0;
#10;
KEY_PRESS =1;// key pressed and first code entered
ITEM_CODE=1;
#10;
KEY_PRESS =0;// key second no pressed
#100;

// Invalid selection 

CARD_IN = 1;// card is inserted
#10;
CARD_IN =0;
#10;
KEY_PRESS =1;// key pressed and first code entered
ITEM_CODE=1;
#10;
KEY_PRESS =0;
#10
KEY_PRESS =1; // key second  pressed
ITEM_CODE= 5;
#10;
KEY_PRESS =0;
#100;



//Invalid transaction due to absence of VALID_TRAN high signal

CARD_IN = 1;// card is inserted
#10;
CARD_IN =0;
#10;
KEY_PRESS =1;// key pressed and first code entered
ITEM_CODE=1;
#10;
KEY_PRESS =0;
#10
KEY_PRESS =1; // key second  pressed
ITEM_CODE= 1;
#10;
KEY_PRESS =0;
#100;


//Successful vend
	
CARD_IN = 1;// card is inserted
#10;
CARD_IN =0;
#10;
KEY_PRESS =1;// key pressed and first code entered
ITEM_CODE=1;
#10;
KEY_PRESS =0;
#10
KEY_PRESS =1; // key second  pressed
ITEM_CODE= 1;
#10;
KEY_PRESS =0;
#30;
VALID_TRN =1;
#10;
VALID_TRN=0;
#100;	
#400;
$stop;
end	
	

endmodule












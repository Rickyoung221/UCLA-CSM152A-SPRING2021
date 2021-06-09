`timescale 1ms / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA
// Engineer: Weikeng Yang
// 
// Create Date: 2021/06/06 19:00:16
// Design Name: 
// Module Name: testbench_40534446443
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
module testbench_405346443;

reg		clk;	//100hz
reg		rst;
reg		rst1;
reg		rst2;

reg		add1;
reg		add2;
reg		add3;
reg		add4;


wire [3:0] val1;
wire [3:0] val2;
wire [3:0] val3;
wire [3:0] val4;
wire [6:0] led_seg; 
wire a1,a2,a3,a4;

parking_meter uut (
.clk(clk),
.rst(rst),
.rst1(rst1), 
.rst2(rst2),		
.add1(add1), 
.add2(add2), 
.add3(add3), 
.add4(add4), 
.val1(val1), 
.val2(val2), 
.val3(val3), 
.val4(val4), 
.led_seg(led_seg), 
.a1(a1), 
.a2(a2), 
.a3(a3), 
.a4(a4)
	);

	initial begin
		clk = 0;
		add1 = 0;
		add2 = 0;
		add3 = 0;
		add4 = 0;
		rst1 = 0;
        rst2 = 0;
        rst = 1; //test rst, precedence over all other inputs
        #10;
        rst = 0;
        rst1 = 0;
		rst2 = 0;
		add1 = 0;
		add2 = 0;
		add3 = 0;
        add4 = 0;
        #4500; 
        //Test 1: check flashing at 1 Hz when idle and no time left
        
		// test each button
        rst2 = 1; //Test 2: test rst2
        #10;
        rst2 = 0;
        #10;
        rst1 = 1; //Test 2: test rst1
        #10;
        rst1 = 0;
		  
		  #10000;
        add1 = 1; //Test 2: test add1
        #10;
        add1 = 0;
        #10;
        add2 = 1; //Test 2: test add2
        #10;
        add2 = 0;
        #10;
        add3 = 1; //Test 2: test add3
        #10;
        add3 = 0;
        #10;
        add4 = 1; //Test 2: test add4
        #10;
        add4 = 0;
        #10;
        #10000;
        rst2 = 1;
        #10;
        rst2 = 0;
        //Tests 3: confirm flashing at 0.5 Hz 
        #10000;
        add1 = 1;
        #10;
        add1 = 0;
        //Test 4: confirm transition from >= 180 to < 180 is correct
        #25000;
        add4 = 1;
        #3000; //Test5: latch to 9999
        add4 = 0;
        #5000; //wait 5 seconds
        add1 = 1; //Test 7: should latch to 9999
        #10;
        add1 = 0; 
        #5000; //wait 5 seconds
        #100;
        $finish;
	end
    
    always begin
        #5;
        clk = ~clk;
    end
      
endmodule


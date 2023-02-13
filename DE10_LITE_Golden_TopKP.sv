
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE10_LITE_Golden_TopKP(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		     [3:0]		VGA_B,
	output		     [3:0]		VGA_G,
	output		          		VGA_HS,
	output		     [3:0]		VGA_R,
	output		          		VGA_VS,

	//////////// Accelerometer //////////
	output		          		GSENSOR_CS_N,
	input 		     [2:1]		GSENSOR_INT,
	output		          		GSENSOR_SCLK,
	inout 		          		GSENSOR_SDI,
	inout 		          		GSENSOR_SDO,

	//////////// Arduino //////////
	inout 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,

	//////////// GPIO, GPIO connect to GPIO Default //////////
	inout 		    [35:0]		GPIO
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
    logic [3:0] rows;		// Read FROM  keypad
    logic clk_slow = 0;		// Clock must be slowed down
    logic [3:0] cols;		// Sent TO keypad
    logic just_pushed;		// Goes high for one clock cycle 
									// when button is pushed
    logic [3:0] outval;		// outval values:
									// 0-9 (4'b0000 to 4'b1001) is a number
                           // 10 (4'b1010) "A" button is "+"
                           // 11 (4'b1011) "B" button is "-"
                           // 12 (4'b1100) "C" button is "x"
                           // 13 (4'b1101) "D" button is "/"
                           // 15 (4'b1110) "#" button is "Clear #" if you have a clear
                           // 14 (4'b1110) "*" button is "=" --> result
    logic [1:0] outtype;	// outypes values:
                           // For numbers outtype 00 --> number
                           // For +, outtype 01 --> operation
                           // For -, outtype 01 --> operation
                           // For x, outtype 01 --> operation
                           // For /, outtype 01 --> operation
                           // # Clear #, outtype 11
                           // For =, outtype 10 --> result
	 int clk_cnt = 0; 		// used to slow clock

    // Creating the keypad hardware:                             
	 keypadController KeypadController1 ( rows, clk_slow, cols, just_pushed, outval, outtype);
	 // See page 31 of manual (Downloaded CD manual)
	     
	 always_ff @ (posedge MAX10_CLK1_50)
	 begin
		if ( clk_cnt < 100 )
			clk_cnt++;
		else
		begin
			clk_slow <= ~clk_slow;
			clk_cnt <= 0;
		end
	 end
	 
	 assign rows[0] = GPIO[24];
	 assign rows[1] = GPIO[22];
	 assign rows[2] = GPIO[20];
	 assign rows[3] = GPIO[18];
	 assign cols[0] = GPIO[16];
	 assign cols[1] = GPIO[14];
	 assign cols[2] = GPIO[12];
	 assign cols[3] = GPIO[10];
	 assign GPIO[0] = SW[0];	// Testing


//=======================================================
//  Structural coding
//=======================================================

	always_comb 
//		case(SW)
//		case(outval)
		case(outtype)
		
			0: HEX0 = 8'b11000000; // "0"
			1: HEX0 = 8'b11111001; // "1" 
			2: HEX0 = 8'b10100100; // "2"
			3: HEX0 = 8'b10110000; // "3"
			4: HEX0 = 8'b10011001; // "4"
			5: HEX0 = 8'b10010010; // "5"
			6: HEX0 = 8'b10000010; // "6"
			7: HEX0 = 8'b11111000; // "7"
			8: HEX0 = 8'b10000000; // "8"
			9: HEX0 = 8'b10010000; // "9"
			10: HEX0 = 8'b10001000; // "A"
			11: HEX0 = 8'b10000011; // "b"
			12: HEX0 = 8'b11000110; // "C"
			13: HEX0 = 8'b10100001; // "d"
			14: HEX0 = 8'b10000110; // "E"
			15: HEX0 = 8'b10001110; // "F"
			default: HEX0 = 8'b110000000; // "0"
		 endcase
		 
	assign HEX1 = 8'hff;
	assign HEX2 = 8'hff;
	assign HEX3 = 8'hff;
	assign HEX4 = 8'hff;
	assign HEX5 = 8'hff;


endmodule

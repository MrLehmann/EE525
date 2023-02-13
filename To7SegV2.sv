// Display module


//////////// SEG7 //////////
//	output		     [7:0]		HEX0,
//	output		     [7:0]		HEX1,
//	output		     [7:0]		HEX2,
//	output		     [7:0]		HEX3,
//	output		     [7:0]		HEX4,
//	output		     [7:0]		HEX5,
//
// This module must be connected at the toplevel.
// In the toplevel, connect to HEX0-HEX5 like this:
//     assign HEX0 = dig[0];
//     assign HEX1 = dig[1];
//   etc.

module To7SegV2 (DispNum, dig);
	input [WIDTH-1:0] DispNum;
	output [5:0] [8:0] dig;

	 int digits [5:0];
    int rem = 0;
    int num_of_digits = 0;
    int digit_val = 0;
	 logic [3:0] dig_loop_cnt = 0;
	 
	 // Set WIDTH to the number of bits in the bus of the number to be displayed
	 localparam WIDTH = 16;
											  
	 localparam logic [7:0] LEDvalues [0:10] = '{8'b11000000,       // 0 for 7-segment display
                                         8'b11111001,        // 1 for 7-segment display
                                         8'b10100100,        // 2 for 7-segment display
                                         8'b10110000,        // 3 for 7-segment display
                                         8'b10011001,        // 4 for 7-segment display
                                         8'b10010010,        // 5 for 7-segment display
                                         8'b10000010,        // 6 for 7-segment display
                                         8'b11111000,        // 7 for 7-segment display
                                         8'b10000000,        // 8 for 7-segment display
                                         8'b10010000,        // 9 for 7-segment display
													  8'b11111111};		 // blank
													  
    function int getnumdigits;
        input int num;
        int num_local;
// SYNTHESIS ERROR 2:
//        while (num_local > 1)
//            begin
//                num_local = num_local/10;
//                num_cnt++;
//            end
//        getnumdigits = num_cnt;
        num_local = num;
        if (num >= 100000) 
            getnumdigits = 6;
        else if (num >= 10000) 
            getnumdigits = 5;
        else if (num >= 1000) 
            getnumdigits = 4;
        else if (num >= 100) 
            getnumdigits = 3;
        else if (num > 10) 
            getnumdigits = 2;
        else if (num > 0) 
            getnumdigits = 1;
		  else 
		      getnumdigits = 1; 
// SAll my loops are failing synthesis......
    endfunction        

	always_comb 
	begin
		rem = DispNum;
		digits[0] = 0;
		digits[1] = 10;
		digits[2] = 10;
		digits[3] = 10;
		digits[4] = 10;
		digits[5] = 10;
		num_of_digits = getnumdigits(DispNum);
		for (int i=0; i < 6; i++)
        begin // More synthesis errors so doing it the messy way
            digits[i] = rem % 10;
            rem = (rem - digits[i])/10;
            if (rem == 0) break;    // https://verificationguide.com/systemverilog/systemverilog-break-and-continue/
        end
	end
		
	assign dig[0] = LEDvalues[digits[0]];
	assign dig[1] = LEDvalues[digits[1]];
	assign dig[2] = LEDvalues[digits[2]];
	assign dig[3] = LEDvalues[digits[3]];
	assign dig[4] = LEDvalues[digits[4]];
	assign dig[5] = LEDvalues[digits[5]];
	
endmodule


/******************************************************************************
 * Controller_TB
 * Testbench for controller module
 *
 * @author Mike Lehmann
 * @date 2/12/2023
 * @version 1.0
 *****************************************************************************/
  `timescale 1ns/1ps
 
module controller_tb;
	logic clk, keyPress;
	logic [1:0] keyType;
	logic memClr;
	logic memSet;
	logic [1:0] memLoc;
	logic [1:0] memDisplay;

	Controller controller1 (.clk(clk), .keyPress(keyPress), .keyType(keyType), 
							.memClr(memClr), .memSet(memSet), .memLoc(memLoc), 
							.memDisplay(memDisplay));

	initial
	begin
		// Not sure how to get the clock in here
		keyPress <= 1;		// Non-blocking
		keyType <= 2'b00;
		#10
		keyPress <= 1;		// Non-blocking
		keyType <= 2'b01;
		#10
		keyPress <= 1;		// Non-blocking
		keyType <= 2'b10;
		#10
		keyPress <= 1;		// Non-blocking
		keyType <= 2'b11;
	end
	
endmodule
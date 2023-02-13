/******************************************************************************
 * Memory_TB
 * Testbench for memory module
 *
 * @author Mike Lehmann
 * @date 2/12/2023
 * @version 1.0
 *****************************************************************************/ 
 `timescale 1ns/1ps
 
module memory_tb;
	logic [3:0] dataIn;
	logic memClr;
	logic memSet;
	logic [1:0] memLoc;
	logic [1:0] memDisplay;
	logic [15:0] dataA;
	logic [15:0] dataB;
	logic [3:0] dataOp;
	logic [15:0] result;
	logic [15:0] dataOut;

	Memory memory1 (.dataIn(dataIn), .memClr(memClr), .memSet(memSet), .memLoc(memLoc),
	                .memDisplay(memDisplay), .dataA(dataA), .dataB(dataB), .dataOp(dataOp),
					.result(result), .dataOut(dataOut));

	initial
	begin
		// Set dataA = 43
		memSet <= 1;
		memClr <= 0;
		memLoc <= 2'b00;
		dataIn <= 4'b0100;
		memDisplay <= 2'b00;
		#10
		memSet <= 1;
		memClr <= 0;
		memLoc <= 2'b00;
		dataIn <= 4'b0011;
		memDisplay <= 2'b00;
		#10
		// Add
		memSet <= 1;
		memClr <= 0;
		memLoc <= 2'b10;
		dataIn <= 4'b1010;
		memDisplay <= 2'b00;
		#10
		// Set dataB = 15
		memSet <= 1;
		memClr <= 0;
		memLoc <= 2'b01;
		dataIn <= 4'b0001;
		memDisplay <= 2'b01;
		#10
		memSet <= 1;
		memClr <= 0;
		memLoc <= 2'b01;
		dataIn <= 4'b0101;
		memDisplay <= 2'b01;
		#10
		memClr <= 0;
	end
	
endmodule
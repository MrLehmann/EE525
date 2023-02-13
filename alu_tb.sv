/******************************************************************************
 * Calculator Project
 * ALU Module TB
 *
 * @author Mike Lehmann
 * @date 1/18/2023
 * @version 1
 *****************************************************************************/
 `timescale 1ns/1ps
 
module alu_tb;
	logic [19:0] A, B;
	logic [1:0] op;	  // op=00 is ADD, op=10 is MUL, op=01 is SUB, op=11 is DIV
	logic [19:0] res;

	alu alu1 (.A(A), .B(B), .op(op), .res(res));

	initial
	begin
		A <= 123;		// Non-blocking
		B <= 321;
		op <= 2'b00;
		#10
		A <= 28;		// Non-blocking
		B <= 6;
		op <= 2'b01;
		#10
		A <= 36;		// Non-blocking
		B <= 17;
		op <= 2'b10;
		#10
		A <= 12;		// Non-blocking
		B <= 4;
		op <= 2'b11;
	end
	
endmodule



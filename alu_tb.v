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
	logic [11:0] A, B;
	logic [1:0] op;						// op=00 is ADD, op=10 is MUL, op=01 is SUB, op=11 is DIV
	logic [11:0] res;

	alu alu1 (.A(A), .B(B), .op(op), .res(res));

	initial
	begin
		A <= 12;		// Non-blocking
		B_tb <= 3;
		op <= 0;
		#10
		A <= 12;		// Non-blocking
		B_tb <= 3;
		op <= 1;
		#10
		A <= -12;		// Non-blocking
		B_tb <= 3;
		op <= 0;
		#10
		A <= -12;		// Non-blocking
		B_tb <= 3;
		op <= 1;
	end
	
endmodule

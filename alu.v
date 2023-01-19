/******************************************************************************
 * Calculator Project
 * ALU Module
 *
 * @author Mike Lehmann
 * @date 1/18/2023
 * @version 1
 *****************************************************************************/
module alu (A, B, op, res);
	input [19:0] A, B;
	input [1:0] op;
	output [19:0] res;
	
	always_comb
	begin
		case(op)
			00: res = A + B;
			01: res = A - B;
			10: res = A * B;
			11: res = A / B;
			default: $display("Invalid Op-Code!");
		endcase
	end
endmodule

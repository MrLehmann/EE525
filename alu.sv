/******************************************************************************
 * Calculator Project
 * ALU Module
 *
 * @author Mike Lehmann
 * @date 1/18/2023
 * @version 1
 *****************************************************************************/
module alu (A, B, op, res);
	input [15:0] A, B;
	input [3:0] op;
	output [15:0] res;
	
	logic [15:0] ALU_Res;
	assign res = ALU_Res;
	
	always_comb
	begin
		case(op)
			4'b1010: ALU_Res = A + B;
			4'b1011: ALU_Res = A - B;
			4'b1100: ALU_Res = A * B;
			4'b1101: ALU_Res = A / B;
			default: ALU_Res = A + B;
		endcase
	end
endmodule

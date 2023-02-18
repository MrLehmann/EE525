/*	Memory
 * Holds values for the digits to be operated on,
 * the operation, and the result of the operation.
 *
 *	@author Mike Lehmann
 * @date 2/12/2023
 * @version 1.0
 */
module Memory(dataIn, memClr, memSet, memLoc, memDisplay, dataA, dataB, dataOp, result, dataOut);
	input [3:0] dataIn;
	input memClr;
	input memSet;
	input [1:0] memLoc;
	input [1:0] memDisplay;
	output [15:0] dataA;
	output [15:0] dataB;
	output [3:0] dataOp;
	input [15:0] result;
	output [15:0] dataOut;
	
	logic [15:0] data1, data2, data_out;
	logic [3:0] op;
	
	always_latch
	begin
		// Check if we are setting Memory
		if (memSet == 1 && memClr == 0)
			begin
				if (memLoc == 2'b00)
					begin
						data1 = data1 * 10 + dataIn;
						//data2 = data2;
						//op = op;
						//data_out = data_out;
					end
				else if (memLoc == 2'b01)
					begin
						data2 = data2 * 10 + dataIn;
						//data1 = data1;
						//op = op;
						//data_out = data_out;
					end
				else
					begin
						op = dataIn;
						//data1 = data1;
						//data2 = data2;
						//data_out = data_out;
					end
			end
		
		if (memDisplay == 2'b00)
			begin
				data_out = data1;
				//data1 = data1;
				//data2 = data2;
				//op = op;
			end
		else if (memDisplay == 2'b01)
			begin
				data_out = data2;
				//data1 = data1;
				//data2 = data2;
				//op = op;
			end
		else
			begin
				data_out = result;
				//data1 = data1;
				//data2 = data2;
				//op = op;
			end
			
		// Check if memory has been cleared
		if (memClr == 1 && memSet == 0)
			begin
				data1 = 0;
				data2 = 0;
				op = 0;
				data_out = 0;
			end
		else if (memClr == 1 && memSet == 1)
			begin
				data1 = 0;
				data2 = 0;
				op = 0;
				data_out = 0;
			end
	end
	
	assign dataA = data1;
	assign dataB = data2;
	assign dataOut = data_out;
	assign dataOp = op;
endmodule

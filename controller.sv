/******************************************************************************
 * Controller
 * Grabs information from the keypad Controller
 * and tells the memory block where to store data
 *
 * @author Mike Lehmann
 * @date 2/12/2023
 * @version 1.0
 *****************************************************************************/
 module Controller(clk, keyPress, keyType, memClr, memSet, memLoc, memDisplay);
	input clk, keyPress;
	input [1:0] keyType;
	output memClr;
	output memSet;
	output [1:0] memLoc;
	output [1:0] memDisplay;
	
	enum {Wait, KeyPressed} state = Wait; 
	
	logic opcode_input = 0;
	logic clr = 0;
	logic set = 0;
	logic [1:0] loc;
	logic [1:0] disp;
  
	always_ff @ (posedge clk) begin 
		case(state)
			Wait: 
				if (keyPress == 1) 
					state <= KeyPressed;
			KeyPressed: 
			begin
				// Check if type is clear (keyType 2'b11)
				if (keyType == 2'b11)
					clr <= 1;
				// Check which memLocation to save to
				else if (keyType == 2'b00)
					begin
						if (opcode_input == 0)
						begin
							// Save memory to location A
							loc <= 2'b00;
							set <= 1;
							disp <= 2'b00;
						end
						else
						begin
							// Save memory to location B
							loc <= 2'b01;
							set <= 1;
							disp <= 2'b01;
						end
					end
				// Check if keyType is operation
				else if (keyType == 2'b01)
				begin
					loc <= 2'b10;
					set <= 1;
					opcode_input <= 1;
				end
				// Check if keyType is equal
				else if (keyType == 2'b10)
				begin
					clr <= 1;
					set <= 0;
					opcode_input <= 0;
					loc <= 2'b11;
				end
				
				// Go back to Wait
				if (keyPressed == 0)
					state <= Wait;
			end
			default: state <= Wait;
		endcase
	end
	
	assign memClr = clr;
	assign memSet = set;
	assign memLoc = loc;
	assign memDisplay = disp;
	
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Tina
// 
// Create Date: 11/2022 
// Module Name: keypadController
// Project Name: Calculator 
// 
//////////////////////////////////////////////////////////////////////////////////

module keypadController(
    input [3:0] rows,
    input clk_slow,
    output [3:0] cols,
    output just_pushed,
    output [3:0] outval,
    output [1:0] outtype
    );
    
    localparam int key_ids[0:15] =  '{1, 2, 3, 10, 4, 5, 6, 11, 7, 8, 9, 12, 14, 0, 15, 13};   
//    localparam int unsigned key_ids[0:15] =  '{1, 2, 3, 0, 4, 5, 6, 2, 7, 8, 9, 3, 2, 0, 15, 14};   
//    localparam int unsigned key_ids[0:15] =  '{1, 2, 3, 0, 4, 5, 6, 2, 7, 8, 9, 3, 2, 0, 15, 14};   
                                    // Key outputs
                                    // Numbers less than 10 are digits, outtype 00 --> number
                                    // 10 A is the code for +, outtype 01 --> operation
                                    // 11 B is the code for -, outtype 01 --> operation
                                    // 12 C is the code for x, outtype 01 --> operation
                                    // 13 D is the code for /, outtype 01 --> operation
                                    // 15 # Clear #, outtype 11
                                    // 14 * is the code for =, outtype 10 --> result
                                    // outtype is 11 ....
    localparam logic unsigned [1:0] key_types[0:15] =  '{0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 2'b11, 0, 2'b10, 1};  
                                    // 0 is a number
                                    // 1 is an operation 
                                    // 2 is #
                                    // 3 is * (ampersand)
    int col_cnt = 0;
    int index_out = 0;
    logic pushed_local;
    logic [3:0] outval_local;
    logic [1:0] outtype_local;
    logic [3:0] cols_work = 0;
    logic [1:0] rows_work;
    enum {COLprep, HOLD1, HOLD2, HOLD3} states = COLprep;
    
    function logic [1:0] getlog2;
        input int num;
        case (num)
            1: getlog2 = 2'b00;
            2: getlog2 = 2'b01;
            4: getlog2 = 2'b10;
            8: getlog2 = 2'b11;
            default: $display("getlog2 error");
        endcase
    endfunction
    
    always_ff @ (posedge clk_slow)
    begin
        case(states)
            COLprep:
                begin
                    if (rows == 0) begin
                        cols_work <= 4'b0001 << col_cnt;
                        col_cnt <= (col_cnt + 1) % 4;
                    end
                    else
                    begin
//                        rows_work <= $clog2(rows);
                        col_cnt <= (col_cnt + 3) % 4;
//                        col_cnt <= (col_cnt - 1);
//                        rows_work <= $clog2(rows);
                        rows_work <= getlog2(rows);
                        states <= HOLD1;
                    end
                end
            HOLD1: 
                begin
                    index_out <= (rows_work*4) + col_cnt;
                    states <= HOLD2;     // Hold output for 3 clock cycles
                end
            HOLD2: 
                begin
                    states <= HOLD3;     // Hold output for 3 clock cycles
                    pushed_local <= 1;
                end
            HOLD3:
                begin
                    pushed_local <= 0;
                    if (rows == 0) begin
                        states <= COLprep;
                        col_cnt <= 0;
                    end
                end
            default:            
                begin
                        col_cnt <= 0;
                        states <= COLprep;
                end
        endcase
    end
    
    assign cols = cols_work;
    assign just_pushed = pushed_local;
    assign outval = key_ids[index_out];
    assign outtype = key_types[index_out];
endmodule

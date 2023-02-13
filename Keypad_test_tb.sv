`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 02:12:00 PM
// Design Name: 
// Module Name: Keypad_test_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Keypad_test_tb;
    // Keypad variables
    logic [3:0] rows;
    logic clk_slow = 0;
    logic [3:0] cols;
    logic key_pushed;
    logic [3:0] data_in;
    logic [1:0] key_type;
    
    always #1 clk_slow = ~clk_slow;
    
    keypadController Keypad1 ( rows, clk_slow, cols, key_pushed, data_in, key_type );
      
    initial 
        begin
            rows = 0;
            #20
            for ( int i = 0 ; i < 50 ; i++ )    // Outputting a number: Col = 1, Row = 1, num=1
                begin
                    #1 if (cols == 1) 
                    begin
                        rows = 1;
                        $display("col 1, row 1 high");
                    end
                    else
                        rows = 0;
                    $display("In for loop %d \n", i);
                end
     
            rows = 0;
            #20
            for ( int i = 0 ; i < 50 ; i++ )    // Outputting a number: Col = 2, Row = 3, num=8
                begin
                    #1 if (cols == 2) 
                    begin
                        rows = 4;
                        $display("col 2, row 3(4) high");
                    end
                     else
                        rows = 0;
                end
                
            rows = 0;
            #20
            for ( int i = 0 ; i < 50 ; i++ )    // Outputting a number: Col = 4, Row = 1, op=+
               begin
                #1 if (cols == 8) 
                begin
                    rows = 1;
                    $display("col 4(8), row 1(1) high");
                end
                else
                   rows = 0;
                end
                
                rows = 0;
                #20
                for ( int i = 0 ; i < 50 ; i++ )    // Outputting a number: Col = 3, Row = 2, num=6
                   begin
                    #1 if (cols == 4) 
                    begin
                        rows = 2;
                        $display("col 3(4), row 2(2) high");
                    end
                    else
                       rows = 0;
                    end
                    
            rows = 0;
                    #20
                    for ( int i = 0 ; i < 50 ; i++ )    // Outputting a number: Col = 1, Row = 4, op=equal
                       begin
                        #1 if (cols == 1) 
                        begin
                            rows = 8;
                            $display("col 1(1), row 4(8) high");
                        end
                        else
                           rows = 0;
                        end
        end
endmodule

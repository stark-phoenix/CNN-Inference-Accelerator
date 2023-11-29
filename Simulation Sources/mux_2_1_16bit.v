`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 01:48:32
// Design Name: 
// Module Name: mux_2_1_16bit
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


module mux_2_1_16bit(
input [15:0] i1, input [15:0] i2, input s, output reg [15:0] out
    );
    initial begin
out = (i1&~s)| (i2&s);
end
endmodule

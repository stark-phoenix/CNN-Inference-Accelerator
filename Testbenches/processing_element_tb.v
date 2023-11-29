`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 18:09:54
// Design Name: 
// Module Name: processing_element_tb
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
module processing_element_tb();
parameter CLK_PERIOD = 10;
  reg clk = 0;
  reg rst = 1; // Initial state: Asserted reset
  reg [23:0] image_bram;
  reg [35:0] weight_bram;
  reg [15:0] partial_sum_bram;
  reg [4:0] exp_bias;
  wire [15:0] pixel;
  processing_element uut (
    .clk(clk),.rst(rst),.image_bram(image_bram),.weight_bram(weight_bram),
    .partial_sum_bram(partial_sum_bram),
    .exp_bias(exp_bias),
    .pixel(pixel)
  );
  always #((CLK_PERIOD / 2)) clk = ~clk;
  initial begin
    image_bram = 24'h123456; // Initialize input values
    weight_bram = 36'hABCDEF0123; // Initialize input values
    partial_sum_bram = 16'h5678; // Initialize input values
    exp_bias = 5'b00100; // Initialize input values
    rst = 1;
    #10 rst = 0;
    #10 image_bram = 24'h987654; // Change input values
    #10 weight_bram = 36'hFEDCBA9876; // Change input values
    #10 partial_sum_bram = 16'h4321; // Change input values
    #10 exp_bias = 5'b11011;
    #100;
    $finish;
  end
endmodule


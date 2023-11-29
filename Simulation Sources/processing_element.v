`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 18:01:32
// Design Name: 
// Module Name: processing_element
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
//input clk,
//input d,
//input rst,
//output reg q,
//output qbar
//);
//    initial begin
//    q=0;
//    end
//    always @(posedge clk)
//    begin
//    if(!rst)
//    q=0;
//    else
//    begin
//    q=d;
//    end 
//    end
//    assign qbar=~q;

module processing_element (
input clk,
input rst,
 
  input [23:0] image_bram,
  input [35:0] weight_bram,
  input [15:0] partial_sum_bram,
  input [4:0] exp_bias,
  output [15:0] pixel
);

  reg [71:0] image_buffer;
  wire [15:0] out1;

  always @ (posedge clk or posedge rst) begin 
  image_buffer = 72'b 0;
  image_buffer[23:0] = image_bram;
  end
    sd4_mac sd1(.clk(clk),.rst(rst),.image(image_buffer), .exp_bias(exp_bias), .weight(weight_bram), .out(out1));
    fp_16_adder ad1(.a(partial_sum_bram), .b(out1), .sum(pixel));


endmodule

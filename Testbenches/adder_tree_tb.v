`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 17:38:09
// Design Name: 
// Module Name: adder_tree_tb
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


module adder_tree_tb;
  reg [15:0] partial_product1; reg [15:0] partial_product2;
  reg [15:0] partial_product3;reg [15:0] partial_product4;
  reg [15:0] partial_product5;reg [15:0] partial_product6;
  reg [15:0] partial_product7;reg [15:0] partial_product8;
  reg [15:0] partial_product9;wire [19:0] sum; 
  adder_tree dut (
    .partial_product1(partial_product1),
    .partial_product2(partial_product2),
    .partial_product3(partial_product3),
    .partial_product4(partial_product4),
    .partial_product5(partial_product5),
    .partial_product6(partial_product6),
    .partial_product7(partial_product7),
    .partial_product8(partial_product8),
    .partial_product9(partial_product9),
    .sum(sum) );
  initial begin
    partial_product1 = 16'h1234;
    partial_product2 = 16'h5678;
    partial_product3 = 16'h9abc;
    partial_product4 = 16'hdef0;
    partial_product5 = 16'h1234;
    partial_product6 = 16'h5678;
    partial_product7 = 16'h9abc;
    partial_product8 = 16'hdef0;
    partial_product9 = 16'h1111; // Example value for partial_product9
    #100;
    $finish;
  end
endmodule


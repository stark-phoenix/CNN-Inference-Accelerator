`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 16:28:07
// Design Name: 
// Module Name: pp_generator_tb
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


module pp_generator_tb;

  reg [7:0] image;
  reg [3:0] weight;
  wire [4:0] signed_pp;
  wire [4:0] exp;

  // Instantiate the pp_generator module
  pp_generator dut (
    .image(image),
    .weight(weight),
    .signed_pp(signed_pp),
    .exp(exp)
  );

  // Initialize signals
  initial begin
    image = 8'b11011010; // Initialize input values
    weight = 4'b1010;    // Initialize input values
    // Apply stimulus (you may change these values)
    #10 image = 8'b10101010; // Change input values
    #10 weight = 4'b0011;    // Change input values
    // Wait for some time to observe the output
    #100;
    // End the simulation
    $finish;
  end
endmodule


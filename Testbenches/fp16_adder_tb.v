`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 19:27:53
// Design Name: 
// Module Name: fp16_adder_tb
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


module tb_fp16_adder;

  // Define signals for the inputs and outputs
  reg [15:0] a;
  reg [15:0] b;
  wire [15:0] sum;
  
  // Instantiate the fp16_adder module
  fp16_adder uut (
    .a(a),
    .b(b),
    .sum(sum)
  );

  // Stimulus generation
  initial begin
    // Test case 1: Positive numbers addition
    a = 16'h3F80; // 1.0 in FP16 format (positive)
    b = 16'h4000; // 2.0 in FP16 format (positive)
    #10; // Wait for a few simulation steps
    if (sum !== 16'h4080) $display("Test Case 1 Failed");
    
    // Test case 2: Negative numbers addition
    a = 16'hC000; // -2.0 in FP16 format (negative)
    b = 16'hC040; // -1.25 in FP16 format (negative)
    #10; // Wait for a few simulation steps
    if (sum !== 16'hBF80) $display("Test Case 2 Failed");
    
    // Add more test cases as needed
    
    // Terminate the simulation
    $finish;
  end

endmodule

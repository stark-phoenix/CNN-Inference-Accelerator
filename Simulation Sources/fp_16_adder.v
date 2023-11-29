`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 20:40:18
// Design Name: 
// Module Name: fp_16_adder
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


//module fp_16_adder(
//input [15:0] a,
//input [15:0] b,
//output reg [15:0] sum
//    );
//reg sign_sum;
//reg [4:0] exponent_sum;
//reg [10:0] mantissa_sum;
//reg [9:0] mantissa_a;
//reg [9:0] mantissa_b;
//reg [4:0] exponent_a;
//reg [4:0] exponent_b;
//reg sign_a;
//reg sign_b;
//initial begin
//mantissa_a = a[9:0];
//exponent_a = a[14:10];
//sign_a = a[15];
//mantissa_b = b[9:0];
//exponent_b = b[14:10];
//sign_b = b[15];


//   // Align the exponents
//always @(*)  begin
//  // Align the exponents.
//  if (exponent_a > exponent_b) begin
//    mantissa_b <= mantissa_b << (exponent_a - exponent_b);
//  end else if (exponent_a < exponent_b) begin
//    mantissa_a <= mantissa_a << (exponent_b - exponent_a);
//  end

//  // Add the mantissas.
//  mantissa_sum <= mantissa_a + mantissa_b;

//  // Normalize the result.
//  while (mantissa_sum[10] == 0) begin
//    mantissa_sum <= mantissa_sum << 1;
//    exponent_sum <= exponent_sum - 1;
//  end

//  // Determine the sign of the sum.
//  sign_sum <= sign_a ^ sign_b;

//  // Set the output.
//  sum <= {sign_sum, exponent_sum, mantissa_sum[9:0]};
//end

module fp_16_adder (
  input [15:0] a, // First FP16 input
  input [15:0] b, // Second FP16 input
  output reg [15:0] sum // Output sum in FP16 format
);
  
  reg [10:0] mantissa_a;
  reg [10:0] mantissa_b;
  reg [4:0] exponent_a;
  reg [4:0] exponent_b;
  reg sign_a;
  reg sign_b;

  reg [10:0] mantissa_sum;
  reg [4:0] exponent_sum;
  reg sign_sum;
  
  always @(*) begin
    mantissa_a = a[9:0];
    exponent_a = a[14:10];
    sign_a = a[15];
    mantissa_b = b[9:0];
    exponent_b = b[14:10];
    sign_b = b[15];
    
    // Calculate the absolute values of the mantissas
    // Note: The leading '1' bit is assumed for normalized numbers
    mantissa_a = (exponent_a == 5'b00000) ? {1'b0, mantissa_a[9:1]} : {1'b1, mantissa_a};
    mantissa_b = (exponent_b == 5'b00000) ? {1'b0, mantissa_b[9:1]} : {1'b1, mantissa_b};
    
    // Align the exponents
    if (exponent_a > exponent_b) begin
      mantissa_b = mantissa_b >> (exponent_a - exponent_b);
      exponent_sum = exponent_a;
    end else begin
      mantissa_a = mantissa_a >> (exponent_b - exponent_a);
      exponent_sum = exponent_b;
    end
    
    // Add or subtract the mantissas based on signs
    if (sign_a == sign_b) begin
      mantissa_sum = mantissa_a + mantissa_b;
      sign_sum = sign_a;
    end else if (mantissa_a >= mantissa_b) begin
      mantissa_sum = mantissa_a - mantissa_b;
      sign_sum = sign_a;
    end else begin
      mantissa_sum = mantissa_b - mantissa_a;
      sign_sum = sign_b;
    end
    
    // Normalize the result
    while (mantissa_sum[10] == 0 && exponent_sum > 0) begin
      mantissa_sum = mantissa_sum << 1;
      exponent_sum = exponent_sum - 1;
    end
 

  
      sum <= {sign_sum, exponent_sum, mantissa_sum[9:0]};
 
end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 16:34:23
// Design Name: 
// Module Name: full_adder_3bit
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


module full_adder_3bit (
  input [2:0] A,
  input [2:0] B,
  output [2:0] Sum,
  output CarryOut
);

  wire [1:0] Sum_2_bits;
  wire CarryOut_2_bits;
  wire x;

  // First stage: Add the least significant bits (LSBs)
  full_adder fa0 (.A(A[0]), .B(B[0]), .Cin(1'b0), .Sum(Sum[0]), .Cout(CarryOut_2_bits));

  // Second stage: Add the two LSB results with the carry-in
  full_adder fa1 (.A(A[1]), .B(B[1]), .Cin(CarryOut_2_bits), .Sum(Sum[1]), .Cout(x));

  // Third stage: Add the carry-out from the second stage to the most significant bits (MSBs)
  full_adder fa2 (.A(A[2]), .B(B[2]), .Cin(x), .Sum(Sum[2]), .Cout(CarryOut));

endmodule

module full_adder (
  input A,
  input B,
  input Cin,
  output Sum,
  output Cout
);

  // Sum bit
  assign Sum = A ^ B ^ Cin;

  // Carry-out bit
  assign Cout = ((A^ B)&Cin)|(A&B);

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2023 15:01:50
// Design Name: 
// Module Name: adder_tree
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


module adder_tree (
  input [15:0] partial_product1, // Nine aligned 16-bit partial products
  input [15:0] partial_product2,
  input [15:0] partial_product3,
  input [15:0] partial_product4,
  input [15:0] partial_product5,
  input [15:0] partial_product6,
  input [15:0] partial_product7,
  input [15:0] partial_product8,
  input [15:0] partial_product9,
  output [19:0] sum // 20-bit sum
);
wire [15:0] s1, s2, s3, s4, s5, s6, s7, s8;
wire c1, c2, c3, c4, c5, c6, c7, c8; 
wire [3:0] carry;
//// Level 1
full_adder_16bit_gate fa0 (.A(partial_product1), .B(partial_product2), .Cin(1'b0), .Sum(s1), .Cout(c1));
full_adder_16bit_gate fa1 (.A(partial_product3), .B(partial_product4), .Cin(1'b0), .Sum(s2), .Cout(c2));
full_adder_16bit_gate fa2 (.A(partial_product5), .B(partial_product6), .Cin(1'b0), .Sum(s3), .Cout(c3));
full_adder_16bit_gate fa3 (.A(partial_product7), .B(partial_product8), .Cin(1'b0), .Sum(s4), .Cout(c4));
////// Level 2
full_adder_16bit_gate fa4 (.A(s1), .B(s2), .Cin(1'b0), .Sum(s5), .Cout(c5));
full_adder_16bit_gate fa5 (.A(s3), .B(s4), .Cin(1'b0), .Sum(s6), .Cout(c6));
////// Level 3
full_adder_16bit_gate fa6 (.A(s5), .B(s6), .Cin(1'b0), .Sum(s7), .Cout(c7));
//////Level 4
full_adder_16bit_gate fa7 (.A(s7), .B(partial_product9), .Cin(1'b0), .Sum(s8), .Cout(c8));
assign carry = c1 +c2+ c3+ c4 + c5 + c6 + c7+ c8;
assign sum = {carry, s8};
endmodule



module full_adder_16bit_gate (
  input [15:0] A,
  input [15:0] B,
  input Cin,
  output [15:0] Sum,
  output Cout);
wire [14:0] C;
full_adder_1bit fa1(.A(A[0]), .B(B[0]), .Cin(Cin), .Sum (Sum[0]), .Cout(C[0]));
full_adder_1bit fa2(.A(A[1]), .B(B[1]), .Cin(C[0]), .Sum (Sum[1]), .Cout(C[1]));
full_adder_1bit fa3(.A(A[2]), .B(B[2]), .Cin(C[1]), .Sum (Sum[2]), .Cout(C[2]));
full_adder_1bit fa4(.A(A[3]), .B(B[3]), .Cin(C[2]), .Sum (Sum[3]), .Cout(C[3]));
full_adder_1bit fa5(.A(A[4]), .B(B[4]), .Cin(C[3]), .Sum (Sum[4]), .Cout(C[4]));
full_adder_1bit fa6(.A(A[5]), .B(B[5]), .Cin(C[4]), .Sum (Sum[5]), .Cout(C[5]));
full_adder_1bit fa7(.A(A[6]), .B(B[6]), .Cin(C[5]), .Sum (Sum[6]), .Cout(C[6]));
full_adder_1bit fa8(.A(A[7]), .B(B[7]), .Cin(C[6]), .Sum (Sum[7]), .Cout(C[7]));
full_adder_1bit fa9(.A(A[8]), .B(B[8]), .Cin(C[7]), .Sum (Sum[8]), .Cout(C[8]));
full_adder_1bit fa10(.A(A[9]), .B(B[9]), .Cin(C[8]), .Sum (Sum[9]), .Cout(C[9]));
full_adder_1bit fa11(.A(A[10]), .B(B[10]), .Cin(C[9]), .Sum (Sum[10]), .Cout(C[10]));
full_adder_1bit fa12(.A(A[11]), .B(B[11]), .Cin(C[10]), .Sum (Sum[11]), .Cout(C[11]));
full_adder_1bit fa13(.A(A[12]), .B(B[12]), .Cin(C[11]), .Sum (Sum[12]), .Cout(C[12]));
full_adder_1bit fa14(.A(A[13]), .B(B[13]), .Cin(C[12]), .Sum (Sum[13]), .Cout(C[13]));
full_adder_1bit fa15(.A(A[14]), .B(B[14]), .Cin(C[13]), .Sum (Sum[14]), .Cout(C[14]));
full_adder_1bit fa16(.A(A[15]), .B(B[15]), .Cin(C[14]), .Sum (Sum[15]), .Cout(Cout));
endmodule
module full_adder_1bit(input A, input B, input Cin, output Sum, output Cout);

assign Sum = A^B^Cin;
assign Cout = ((A^B)&Cin) | (A&B);
endmodule



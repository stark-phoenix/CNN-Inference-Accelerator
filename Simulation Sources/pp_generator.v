`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2023 02:49:54
// Design Name: 
// Module Name: pp_generator
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


`timescale 1ns / 1ps


module pp_generator(
input clk,
input rst,
input [7:0] image,
input [3:0] weight,
output [4:0] signed_pp,
output  [4:0] exp);
integer i;
wire sign;
reg select;
reg x;
reg y;
reg [4:0] z;
reg [4:0] w;
//wire [4:0] a;
//wire [4:0] b;

//assign a = signed_pp;
//assign b = exp;
assign sign = (image[7])^(weight[3]);
always @(posedge clk) begin
 if(!rst)begin
   x =image[0];
   y =1'b0;
   z = 5'b00000;
   w = 5'b00000;
   //sign = 1'b0;
   select = 1'b0;
//   signed_pp = 5'b00000;
//   exp = 5'b00000;
 end
end
always @(posedge clk) begin
  
  
  for(i=1;i<7;i=i+1)begin
   x <= ~(x|image[i]);
  end
  y <= weight[2]&weight[1]&weight[0];
  select <= x|y;
  z<= image[6:3] + weight[2:0];

  w <= {sign, 1'b1, image[2:0]};

 end
 
  mux_2_1 m1(.i1(w), .i2(5'b0), .s(select), .out(signed_pp));
  mux_2_1 m2(.i1(z), .i2(5'b0), .s(select), .out(exp));


endmodule

module mux_2_1(input [4:0] i1, input [4:0] i2, input s, output   [4:0] out);

assign out = (i1&~s)| (i2&s);

endmodule




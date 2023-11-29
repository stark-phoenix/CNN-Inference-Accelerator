`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2023 14:32:01
// Design Name: 
// Module Name: alignment
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

module alignment(
input clk,
input rst,
input [4:0] exp,
input [4:0] exp_max, 
input [4:0] signed_pp,
output reg [15:0] aligned_pp );
reg [4:0] exp_diff;
reg [14:0] x;
reg [14:0] y;
reg [15:0] z;
//always @(posedge clk or negedge rst)begin 
//  if(!rst)begin
//   //x =1'b0;
//   //y =1'b0;
//   //z = 5'b00000;
//   //exp_diff = 5'b00000;
//   //aligned_pp = 15'h0000;
//  end
    
//end
always @(posedge clk)begin
    exp_diff <= exp_max - exp;
    x <= {signed_pp[3:0], 11'b0};
    y <= x >> exp_diff;
    z <= {signed_pp[4],y};
    aligned_pp <= ~z +1'b1;
end


endmodule


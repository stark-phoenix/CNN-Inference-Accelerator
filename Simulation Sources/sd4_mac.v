`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 20:30:27
// Design Name: 
// Module Name: sd4_mac
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
module sd4_mac(input clk,input rst,input [71:0] image,input [4:0] exp_bias,input [35:0] weight,output [15:0] out );
wire [4:0] pp1,pp2, pp3, pp4, pp5, pp6,pp7,pp8, pp9; //output of pp generator
wire [4:0] exp1,exp2 ,exp3 ,exp4 ,exp5,exp6,exp7,exp8,exp9; //output of pp generator
wire [15:0] aligned_pp1, aligned_pp2, aligned_pp3, aligned_pp4, aligned_pp5, aligned_pp6, aligned_pp7,aligned_pp8,aligned_pp9;
wire [19:0] signed_sum; // ouput of adder__tree
wire sign;
wire [10:0] norm_sum;
wire [6:0] exp_final;
reg [4:0] maxi;
pp_generator ppg1(.clk(clk),.rst(rst),.image(image[7:0]), .weight(weight[3:0]),.signed_pp(pp1), .exp(exp1));
pp_generator ppg2(.clk(clk),.rst(rst),.image(image[15:8]), .weight(weight[7:4]),.signed_pp(pp2), .exp(exp2));
pp_generator ppg3(.clk(clk),.rst(rst),.image(image[23:16]), .weight(weight[11:8]),.signed_pp(pp3), .exp(exp3));
pp_generator ppg4(.clk(clk),.rst(rst),.image(image[31:24]), .weight(weight[15:12]),.signed_pp(pp4), .exp(exp4));
pp_generator ppg5(.clk(clk),.rst(rst),.image(image[39:32]), .weight(weight[19:16]),.signed_pp(pp5), .exp(exp5));
pp_generator ppg6(.clk(clk),.rst(rst),.image(image[47:40]), .weight(weight[23:20]),.signed_pp(pp6), .exp(exp6));
pp_generator ppg7(.clk(clk),.rst(rst),.image(image[55:48]), .weight(weight[27:24]),.signed_pp(pp7), .exp(exp7));
pp_generator ppg8(.clk(clk),.rst(rst),.image(image[63:56]), .weight(weight[31:28]),.signed_pp(pp8), .exp(exp8));
pp_generator ppg9(.clk(clk),.rst(rst),.image(image[71:64]), .weight(weight[35:32]),.signed_pp(pp9), .exp(exp9));
always @(posedge clk or rst)begin
    if(!rst)begin
     maxi = 5'b0;
    end
    if (exp1 > exp2) begin
      maxi <= exp1;
    end else begin
    if(maxi < exp3) begin
      maxi <= exp3;
    end else begin
    if(maxi < exp4)  begin
      maxi <= exp4;
    end else begin 
    if (maxi < exp5) begin
      maxi <= exp5;
    end else begin 
    if (maxi < exp6) begin
      maxi <= exp6;
    end else begin 
    if (maxi < exp7) begin
      maxi <= exp7;
    end else begin
    if (maxi < exp8) begin
      maxi <= exp8;
    end else begin
    if (maxi < exp9) begin
       maxi <= exp9;
    end  
        end
       end 
      end
     end
    end
   end
  end
 end
alignment a1(.clk(clk),.rst(rst),.exp(exp1), .exp_max(maxi), .signed_pp(pp1), .aligned_pp(aligned_pp1));
alignment a2(.clk(clk),.rst(rst),.exp(exp2), .exp_max(maxi), .signed_pp(pp2), .aligned_pp(aligned_pp2));
alignment a3(.clk(clk),.rst(rst),.exp(exp3), .exp_max(maxi), .signed_pp(pp3), .aligned_pp(aligned_pp3));
alignment a4(.clk(clk),.rst(rst),.exp(exp4), .exp_max(maxi), .signed_pp(pp4), .aligned_pp(aligned_pp4));
alignment a5(.clk(clk),.rst(rst),.exp(exp5), .exp_max(maxi), .signed_pp(pp5), .aligned_pp(aligned_pp5));
alignment a6(.clk(clk),.rst(rst),.exp(exp6), .exp_max(maxi), .signed_pp(pp6), .aligned_pp(aligned_pp6));
alignment a7(.clk(clk),.rst(rst),.exp(exp7), .exp_max(maxi), .signed_pp(pp7), .aligned_pp(aligned_pp7));
alignment a8(.clk(clk),.rst(rst),.exp(exp8), .exp_max(maxi), .signed_pp(pp8), .aligned_pp(aligned_pp8));
alignment a9(.clk(clk),.rst(rst),.exp(exp9), .exp_max(maxi), .signed_pp(pp9), .aligned_pp(aligned_pp9));
adder_tree ad1(
               .partial_product1(aligned_pp1),
               .partial_product2(aligned_pp2),
               .partial_product3(aligned_pp3),
               .partial_product4(aligned_pp4),
               .partial_product5(aligned_pp5),
               .partial_product6(aligned_pp6),
               .partial_product7(aligned_pp7),
               .partial_product8(aligned_pp8),
               .partial_product9(aligned_pp9),
               .sum(signed_sum));
normalisation n1(.clk(clk), .rst(rst),.signed_sum(signed_sum), .exp_max(maxi), .sign(sign), .norm_sum(norm_sum), .exp_final(exp_final) );              
subnormal_handling sb1(.clk(clk),.rst(rst),.exp_final(exp_final), .sign(sign), .norm_sum(norm_sum), .out(out));
endmodule




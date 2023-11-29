`timescale 1ns / 1ps

module subnormal_handling(
input clk,
input rst,
input [6:0] exp_final,
input sign,
input [10:0] norm_sum,
output [15:0] out);
    
    reg select;
    reg [11:0] x;
    reg [15:0] y; 
    
    always @(posedge clk )begin 
     x <= {sign, norm_sum};
     if (exp_final< 7'd1)begin
     select <= 1'b1;
     end else begin
     select <=1'b0;
     end
     y <= x >> exp_final;
    end
    
    mux_2_1_16bit m2(.i1({sign, exp_final[4:0], norm_sum[9:0]}), .i2(y), .s(select), .out(out));
endmodule

module mux_2_1_16bit(
input [15:0] i1, input [15:0] i2, input s, output [15:0] out
    );
    
    assign out = (i1&(~s))| (i2&s);
   
  endmodule

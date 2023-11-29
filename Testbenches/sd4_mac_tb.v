`timescale 1ns / 1ps
module sd4_mac_tb();
  reg clk;
  reg rst;
  reg [71:0] image;
  reg [4:0] exp_bias;
  reg [35:0] weight;
  wire [15:0] out;
  sd4_mac uut (
    .clk(clk),.rst(rst),.image(image),.exp_bias(exp_bias),.weight(weight),.out(out)
  );
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst = 1'b1;
    #1 rst = 1'b0;
    image = 72'hc123456789abcdeeff;
    exp_bias = 5'b11101;
    weight = 36'h111111111;
    #150;
    image = 72'h1123336789abcd222f;
    exp_bias = 5'b01110;
    weight = 36'h333445633;
    #100;
    image = 72'ha173406709abcdeeff;
    exp_bias = 5'b01001;
    weight = 36'h000000000;
  end
endmodule

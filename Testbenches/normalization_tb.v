// Code your testbench here
// or browse Examples
module normalisation_tb;
  reg clk;
  reg rst;
  reg [19:0] signed_sum;
  reg [5:0] exp_max;
  wire sign;
  wire [10:0] norm_sum;
  wire [6:0] exp_final;
  normalisation nm(
    .clk(clk),
    .rst(rst),
    .signed_sum(signed_sum),
    .exp_max(exp_max),
    .sign(sign),
    .norm_sum(norm_sum),
    .exp_final(exp_final));
  
  
  initial begin 
    //$monitor("sign = %b, norm_sum = %b, exp_final = %b", sign ,norm_sum, exp_final);
    clk = 1'b0;
    rst = 1'b1; 
    #10 rst = 1'b0; 
    signed_sum = 20'b10011100011100011100;
    exp_max = 6'b100111;
    #10
    signed_sum = 20'b00011100011100011100;
    exp_max = 6'b110111;
    #10
    signed_sum = 20'b01011100011101011100;
    exp_max = 6'b101111;
    #10
    signed_sum = 20'b00011101011100111100;
    exp_max = 6'b010101;
  end
  
  always #10 clk = ~clk;
  

  //$dumpfile("dump.vcd");
  
endmodule
`timescale 1ns / 1ps

module subnormal_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in nanoseconds

  // Signals
  reg clk = 0;
  reg rst = 0;
  reg [6:0] exp_final;
  reg sign;
  reg [10:0] norm_sum;
  wire [15:0] out;

  // Instantiate the module under test
  subnormal_handling uut (
    .clk(clk),
    .rst(rst),
    .exp_final(exp_final),
    .sign(sign),
    .norm_sum(norm_sum),
    .out(out)
  );

  // Clock generation
  always #((CLK_PERIOD / 2)) clk = ~clk;

  // Initial block
  initial begin
    // Initialize inputs
    exp_final = 7'b0;
    sign = 1'b0;
    norm_sum = 11'b0;

    // Apply inputs and observe outputs
    #5 rst = 1; // Assert reset
    #5 rst = 0; // Release reset
    #5 exp_final = 7'b0111111; // Example exponent value
    #5 sign = 1'b1; // Example sign value
    #5 norm_sum = 11'b01010101010; // Example mantissa value

    // Display results
    $display("Input: clk=%b rst=%b exp_final=%b sign=%b norm_sum=%b", clk, rst, exp_final, sign, norm_sum);
    #10; // Wait for a few cycles
    $display("Output: out=%b", out);

    // Add additional tests as needed

    // Add additional checks or assertions as needed

    // Finish simulation
    #10 $finish;
  end

endmodule

module mux_2_1_16bit(
  input [15:0] i1,
  input [15:0] i2,
  input s,
  output wire [15:0] out
);
  assign out = (i1 & ~s) | (i2 & s);
endmodule

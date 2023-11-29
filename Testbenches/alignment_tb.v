`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 17:31:27
// Design Name: 
// Module Name: alignment_tb
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


module alignment_tb;

  reg [4:0] exp;
  reg [4:0] exp_max;
  reg [4:0] signed_pp;
  wire [15:0] aligned_pp;

  // Instantiate the alignment module
  alignment dut (
    .exp(exp),
    .exp_max(exp_max),
    .signed_pp(signed_pp),
    .aligned_pp(aligned_pp)
  );
  // Initialize signals
  initial begin
    exp = 5'b00010;       // Initialize input values
    exp_max = 5'b00101;   // Initialize input values
    signed_pp = 5'b11010; // Initialize input values

    // Apply stimulus (you may change these values)
    #10 exp = 5'b00100;       // Change input values
    #10 exp_max = 5'b01010;   // Change input values
    #10 signed_pp = 5'b00111; // Change input values
    // Wait for some time to observe the output
    #100;
    // End the simulation
    $finish;
  end

endmodule


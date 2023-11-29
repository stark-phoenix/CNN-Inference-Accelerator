// Code your design here
`timescale 1ns/1ps

module normalisation(
input clk, 
input rst,
input [19:0] signed_sum,
input [4:0] exp_max,
output sign,
output [10:0] norm_sum,
output [6:0] exp_final);
  
reg [19:0] unsigned_sum;
wire [14:0] x;
reg z;
integer i;
reg [10:0] shifted_sum;
reg [4:0] exp_diff;
wire exp_carry;


always @(posedge clk or rst)begin 
    if(!rst)begin
     z = 1'b0;
     
     end
end
   assign sign = signed_sum[19];
   //assign x = unsigned_sum[14:0];
always @(posedge clk)begin 
   if(sign==1'b1)begin
      unsigned_sum = signed_sum;
      end
   else begin
      unsigned_sum = ~signed_sum +1'b1;
      end
end
// leading one detector
always @(posedge clk)begin
 for ( i=0; i<15; i=i+1)begin
    z = (unsigned_sum[i]==1'b1)? i : z ; 
 end
  shifted_sum <= unsigned_sum >> z;
  exp_diff = z;
end

round_to_nearest_even r1(.num(shifted_sum), .rounded_num(norm_sum), .exp_carry(exp_carry));
signed_adder s1(.A(exp_diff), .B(exp_max), .Cin(exp_carry), .Sum(exp_final));
endmodule


module round_to_nearest_even(
  input [10:0] num,
  output reg [10:0] rounded_num,
  output reg exp_carry
);

  wire is_odd;

  // Determine if the input number is odd
  assign is_odd = (num[0] == 1'b1);

  // Round to nearest even
  always @(*) begin
    if (is_odd)
      {exp_carry,rounded_num} = num + 1;
    else
      {exp_carry,rounded_num} = num;
  end

endmodule


module signed_adder (
  input [4:0] A, 
  input [4:0] B, 
  input Cin,     
  output [6:0] Sum 
  );
  assign Sum = Cin + A + B;

endmodule

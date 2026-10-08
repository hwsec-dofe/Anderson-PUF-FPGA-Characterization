`timescale 1ns / 1ps

module clock_divider_counter #(parameter integer DIVISOR = 100_000_000) // divide by 50k for a 2KHz out if clk is 100MHz
(
  input clk,
  output reg clk_div = 0
);

reg [28:0] count = 0;

always @(posedge clk) begin
    if(count == DIVISOR - 1)
        count <= 0;
    else
        count <= count + 1;
end

always @(posedge clk) begin
  if(count == DIVISOR - 1)
    clk_div <= ~clk_div;
end

endmodule

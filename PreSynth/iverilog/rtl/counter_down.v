`timescale 1ns / 1ps



module counter_down #(parameter LOG2_N_TAPS=8)(
    input reset, clk,
    output reg [(LOG2_N_TAPS-1):0] counter = {LOG2_N_TAPS{1'b1}}
);
initial begin
    counter = {LOG2_N_TAPS{1'b1}};
    end
  always@(posedge clk)
  begin
  if (reset)
    counter = {LOG2_N_TAPS{1'b1}};
  else
    counter = (counter - 1);
  end

endmodule
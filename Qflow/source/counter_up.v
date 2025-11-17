`timescale 1ns / 1ps

 module counter_up #(parameter LOG2_N_TAPS = 4)(
    input reset, clk,
    output reg [(LOG2_N_TAPS-1):0] counter = 0
);
    initial begin
        counter = 0;
        end
      always@(posedge clk)
      begin
      if (reset)
        counter <= 0;
      else
        counter <= (counter + 1);
      end
      
endmodule

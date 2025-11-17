`timescale 1ns / 1ps



module rom #(parameter WIDTH_COEF0 = 8, parameter N_TAPS = 16, parameter LOG2_N_TAPS = 4)(
    input clk, reset,
    input [LOG2_N_TAPS-1:0] address,
    output reg [WIDTH_COEF0-1:0] data = 0
    );
    
    reg [WIDTH_COEF0-1:0] rom [0:N_TAPS-1];
    
  always @(posedge clk) 
    begin
      if (reset)
          data <= 'b0;
      else 
          data <= rom[address];
      end
    
  initial begin
    $readmemb("rom.mem",rom);
  end
endmodule

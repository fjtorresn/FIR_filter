`timescale 1ns / 1ps

module asr #(parameter WIDTH_DATA = 8, parameter N_TAPS = 16, parameter LOG2_N_TAPS = 4)(
    input clk, reset,
    input [WIDTH_DATA-1:0] q,
    input [LOG2_N_TAPS-1:0] addr,
    input enable,
    output reg [WIDTH_DATA-1:0] dataout = 0,
    output reg [WIDTH_DATA-1:0] en = 0
    );
   
   reg [WIDTH_DATA-1:0] rom [N_TAPS-1:0];
   reg [LOG2_N_TAPS:0] index;
   
   always@(posedge clk, posedge reset)
   begin
   if (reset)
        for(index = 0; index < N_TAPS; index = index + 1) rom[index] <= 0;
   else
       begin
        rom[0] <= q;
        for(index = 1; index < N_TAPS; index = index + 1) rom[index] <= rom[index-1];
       end
   end
   always@(*) begin dataout = rom[addr]; en = rom[N_TAPS-1]; end
   
   initial begin
    for(index = 0; index < N_TAPS; index = index + 1) begin
       rom[index] <= 0;
   end
   end  
endmodule

`timescale 1ns / 1ps


module counter_up_TB;

parameter N = 8;

reg clk, reset;
wire [N-1:0] counter;

counter_up #(N) uut(reset, clk, counter);

initial begin
    clk = 0;
    reset = 0;
    repeat(15) #5 clk = !clk;
    reset = 1;
    repeat(3) #5 clk = !clk;
    reset = 0;
    repeat(100) #5 clk = !clk;
    
end
endmodule
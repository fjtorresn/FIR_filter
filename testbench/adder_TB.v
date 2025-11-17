`timescale 1ns / 1ps


module adder_TB;

parameter N = 8;

reg clk, rst, enable;
reg [7:0] sum1, sum2;
wire [7:0] res;

adder #(N,1) uut(.sum1(sum1), .sum2(sum2), .clk(clk), .res(res), .rst(rst));

initial begin
    clk = 0;
    rst = 0;
    sum1 = 0;
    sum2 = 0;
    repeat(15) #5 clk = !clk;
    rst = 1;
    repeat(3) #5 clk = !clk;
    rst = 0;
    repeat(6) #5 clk = !clk;
    sum1 = 2;
    sum2 = 4;
    repeat(6) #5 clk = !clk;
    sum1 = 5;
    sum2 = 8;
    repeat(6) #5 clk = !clk;
    sum1 = 11;
    sum2 = 3;
    repeat(100) #5 clk = !clk;
    
end
endmodule
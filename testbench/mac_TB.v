`timescale 1ns / 1ps


module mac_TB;

parameter N = 8;

reg clk, rst, enable;
reg [7:0] a, b;
wire [7:0] dataout;

mac #(N,1) uut(.a(a), .b(b), .clk(clk), .reset(rst), .dataout(dataout));

initial begin
    clk = 0;
    rst = 0;
    a = 0;
    b = 0;
    repeat(15) #5 clk = !clk;
    rst = 1;
    repeat(3) #5 clk = !clk;
    rst = 0;
    repeat(5) #5 clk = !clk;
    a = 2;
    b = 5;
    repeat(2) #5 clk = !clk;
    a = 3;
    b = 1;
    repeat(2) #5 clk = !clk;
    a = 6;
    b = 2;
    repeat(100) #5 clk = !clk;
    
end
endmodule
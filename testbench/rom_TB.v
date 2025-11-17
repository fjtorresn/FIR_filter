`timescale 1ns / 1ps


module rom_TB;

parameter N=8;

reg [N-1:0] address;
reg clk, reset;
wire [N-1:0] data;

rom #(N) uut(.clk(clk), .reset(reset), .address(address), .data(data));

initial begin
    clk = 0;
    reset = 0;
    repeat(4) #5 clk = !clk;
    address = 4;
    repeat(4) #5 clk = !clk;
    address = 3;
    repeat(4) #5 clk = !clk;
    address = 2;
    repeat(4) #5 clk = !clk;
    address = 7;
    repeat(4) #5 clk = !clk;
    reset = 1;
    repeat(2) #5 clk = !clk;
    reset = 0;
    repeat(4) #5 clk = !clk;
    address = 6;
    repeat(4) #5 clk = !clk;
    address = 1;
    repeat(4) #5 clk = !clk;
    address= 3;
    repeat(4) #5 clk = !clk;
    address = 6;
    repeat(4) #5 clk = !clk;
end


endmodule
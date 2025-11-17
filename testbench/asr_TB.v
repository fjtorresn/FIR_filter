`timescale 1ns / 1ps


module asr_TB;

parameter N=8;

reg clk, reset;
reg [N-1:0] datain;
reg [3:0] address;
wire [N-1:0] dataout;

asr #(N,16) uut(.clk(clk), .reset(reset), .q(datain), .addr(address), .dataout(dataout), .enable(1'b1));

    initial begin
        clk = 0;
        reset = 0;
            datain = 'd0;
            address = 4;
            repeat(4) #5 clk = !clk;
            address = 1;
            datain = 'd1;
            repeat(4) #5 clk = !clk;
            address = 7;
            datain = 'd2;
            repeat(4) #5 clk = !clk;
            address = 5;
            datain = 'd3;
            repeat(4) #5 clk = !clk;
            reset = 1;
            repeat(2) #5 clk = !clk;
            reset = 0;
            repeat(4) #5 clk = !clk;
            address = 3;
            datain = 'd4;
            repeat(4) #5 clk = !clk;
            address = 6;
            datain = 'd5;
            repeat(4) #5 clk = !clk;
            address = 2;
            datain = 'd6;
            repeat(4) #5 clk = !clk;
            address= 3;
            datain = 'd8;
            datain = 'd0;
            repeat(4) #5 clk = !clk;
            datain = 'd4;
            repeat(100) #5 clk = !clk;
    end
endmodule
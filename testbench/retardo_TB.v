`timescale 1ns / 1ps


module retardo_TB;

parameter N = 8;

reg clk, rst, enable;
reg [7:0] datain;
wire [7:0] dataout;

retardo #(N,1) uut(.datain(datain), .dataout(dataout), .clk(clk), .rst(rst), .enable(1'b1));

initial begin
    clk = 0;
    rst = 0;
    datain = 0;
    repeat(15) #5 clk = !clk;
    rst = 1;
    repeat(3) #5 clk = !clk;
    rst = 0;
    repeat(3) #5 clk = !clk;
    datain = 10;
    repeat(100) #5 clk = !clk;
    
end
endmodule
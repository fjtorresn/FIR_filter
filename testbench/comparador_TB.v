`timescale 1ns / 1ps


module comparador_TB;

parameter N = 8;

reg clk, rst, enable;
reg [7:0] datain;
wire dataout;

comparador #(N,1) uut(.datain(datain), .dataout(dataout), .clk(clk), .rst(rst));

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
    repeat(3) #5 clk = !clk;
    datain = 0;
    repeat(100) #5 clk = !clk;
    
end
endmodule
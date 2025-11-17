`timescale 1ns / 1ps


module clkdiv_TB;

parameter N = 8;

reg clkin, rst;
wire clkout;

clkdiv #(N,3) uut(.clkin(clkin), .clkout(clkout), .reset(rst));

initial begin
    clkin = 0;
    rst = 0;
    repeat(15) #5 clkin = !clkin;
    rst = 1;
    repeat(3) #5 clkin = !clkin;
    rst = 0;
    repeat(100) #5 clkin = !clkin;
    
end
endmodule
`timescale 1ns / 1ps



module mac #(parameter WIDTH_DATA = 8, parameter N_TAPS = 16, parameter WIDTH_MAC_OUT = 8, parameter WIDTH_COEF0 = 8)(
    input [WIDTH_DATA - 1:0] a,
    input [WIDTH_COEF0 - 1:0]b,
    input reset, clk,
    output reg [WIDTH_MAC_OUT - 1:0] dataout = 0);
    
    reg [WIDTH_MAC_OUT - 1:0] q;
    
    always@(*)begin
        q = dataout + a*b;
    end
    always@(posedge clk)
    begin
    if (reset)
        dataout <= a*b;
    else 
        dataout <= q;
    end
endmodule

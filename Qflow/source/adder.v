`timescale 1ns / 1ps


module adder #(parameter WIDTH_DATA=8)(
    input clk, rst,
    input [WIDTH_DATA-1:0] sum1,
    input [WIDTH_DATA-1:0] sum2,
    output reg [WIDTH_DATA-1:0] res = 0
    );
    
    always@(posedge clk) begin
        if(rst) res <= 0; 
        else res <= sum1 + sum2;
    end
endmodule

`timescale 1ns / 1ps



module register #(parameter WIDTH_DATA = 8)(
    input [WIDTH_DATA-1:0] datain,
    input clk, enable, reset,
    output reg [WIDTH_DATA-1:0] dataout = 0
    );   
    
    always@(posedge clk, posedge reset)
    begin
    if (reset)
        dataout <= 'b0;
    else 
        if (enable)
            dataout <= datain;
        else dataout <= dataout;
    end
        
endmodule

`timescale 1ns / 1ps

module comparador #(parameter LOG2_N_TAPS = 4)(
    input [(LOG2_N_TAPS-1):0] datain,
    input clk, rst,
    output reg dataout
    );
    always@(posedge clk) begin
        if(rst) dataout <= 0;
        else begin 
		if (datain == 0) dataout <= 1;
        	else dataout <= 0; end
    end
endmodule

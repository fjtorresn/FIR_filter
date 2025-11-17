`timescale 1ns/1ns

module retardo #(parameter WIDTH = 8, parameter R = 2)(
    input [WIDTH - 1:0] datain,
    input clk, rst, enable,
    output reg [WIDTH - 1:0] dataout);
     
    reg [R:0] i;   
    reg [WIDTH-1:0] rf [R-1:0];

    always @(posedge clk)
    begin
    if (rst) 
	begin
        dataout <= 'b0;
        for(i = 0; i < R; i=i+1)
            rf[i] = 0;
	end
    else 
        if (enable)
            begin
              rf[0] <= datain;
              for(i = 0; i < R-1; i = i+1) begin
                  rf[i+1] <= rf[i];
                  end
              dataout <= rf[R-1];
            end
        else dataout <= 0;
    end
    initial begin
      for(i = 0; i < R; i=i+1)
          rf[i] = 0;
    end
endmodule

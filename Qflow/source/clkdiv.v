`timescale 1ns / 1ps

module clkdiv #(parameter N = 8, parameter LOG2_N = 3)(
    input clkin, reset,
    output reg clkout = 1
    );
    reg [LOG2_N-1:0] div = 0;
    always@(posedge clkin)
    begin
    if (reset) begin div <= 0; clkout <= 1'b1; end
    else begin
        if(div == N-1)
        begin
            clkout <= ~clkout;
            div <= 0;
        end
        else begin clkout <= clkout; div <= div + 1; end
    end
    end
endmodule

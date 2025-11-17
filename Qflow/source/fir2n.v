`timescale 1ns / 1ps

module fir2n #(parameter WIDTH_DATA = 8, parameter N_TAPS = 16, parameter LOG2_N_TAPS = 4, parameter WIDTH_COEF0 = 8, parameter WIDTH_MAC_OUT = 8)(
    input clk, rst,
    input [WIDTH_DATA-1:0] din,
    output [WIDTH_MAC_OUT-1:0] dout
    );
    
    wire clkout;
    wire [WIDTH_DATA-1:0] q;
    wire [WIDTH_DATA-1:0] a;
    wire [WIDTH_DATA-1:0] b;
    wire [(LOG2_N_TAPS-1):0] addr1;
    wire [(LOG2_N_TAPS-1):0] addr2;
    wire [WIDTH_DATA - 1:0] m1;
    wire [WIDTH_COEF0 - 1:0] m2;
    wire r2;
    wire r3;
    wire [WIDTH_MAC_OUT-1:0] q1;
    wire [WIDTH_MAC_OUT-1:0] qfinal;
    wire [WIDTH_DATA - 1:0] aux1;
    wire [WIDTH_DATA - 1:0] nada;
    
    clkdiv #(N_TAPS>>1,3) clk2(.clkin(clk),.clkout(clkout), .reset(rst));
    register #(WIDTH_DATA) reg1(.datain(din), .dataout(q), .reset(rst) ,.clk(clkout), .enable(1'b1));
    counter_up #(LOG2_N_TAPS) counterup(.reset(rst), .clk(clk), .counter(addr1));
    counter_down #(LOG2_N_TAPS) counterdown(.reset(rst), .clk(clk), .counter(addr2));
    asr #(WIDTH_DATA, N_TAPS, LOG2_N_TAPS) asr1(.q(q), .addr(addr1), .clk(clkout), .reset(rst), .enable(1'b1), .dataout(a), .en(aux1));
    asr #(WIDTH_DATA, N_TAPS, LOG2_N_TAPS) asr2(.q(aux1), .addr(addr2), .clk(clkout), .reset(rst), .enable(1'b1), .dataout(b), .en(nada));
    adder #(WIDTH_DATA) sumador(.sum1(a), .sum2(b), .clk(clk), .res(m1), .rst(rst));
    rom #(WIDTH_COEF0, N_TAPS, LOG2_N_TAPS) rom1(.clk(clk), .reset(rst), .address(addr1), .data(m2));
    comparador #(LOG2_N_TAPS) comp(.datain(addr1), .clk(clk), .dataout(r2), .rst(rst));
    retardo #(1, 15) ret2(.datain(r2), .dataout(r3), .clk(clk), .rst(rst), .enable(1'b1));
    mac #(WIDTH_DATA, N_TAPS, WIDTH_MAC_OUT, WIDTH_COEF0) mac1(.a(m1), .b(m2), .reset(r3), .clk(clk), .dataout(q1));
    register #(WIDTH_DATA) reg2(.datain(q1), .dataout(qfinal), .reset(rst) ,.clk(clk), .enable(r3));
    register #(WIDTH_DATA) reg3(.datain(qfinal), .dataout(dout), .reset(rst) ,.clk(clkout), .enable(1'b1));
    

endmodule

`timescale 1ns / 1ps

module fir2n_TB;

parameter WIDTH_DATA = 8;
parameter WIDTH_COEF0 = 8;
parameter N_TAPS = 16;
parameter LOG2_N_TAPS = 4;
parameter WIDTH_MAC_OUT = 8;

reg clk, rst;
reg [WIDTH_DATA-1:0] din;
wire [WIDTH_MAC_OUT-1:0] dout;

fir2n #(.WIDTH_DATA(WIDTH_DATA), .N_TAPS(N_TAPS), .LOG2_N_TAPS(LOG2_N_TAPS), .WIDTH_COEF0(WIDTH_COEF0), .WIDTH_MAC_OUT(WIDTH_MAC_OUT)) uut(.clk(clk), .rst(rst), .din(din), .dout(dout));

initial begin
    $dumpfile("fir2n_TB.vcd");
    $dumpvars(0,fir2n_TB);
    clk = 0;
    rst = 0;
    din = 0;
    #50; rst = 1;
    repeat(100) #10 clk = ~clk;
    rst = 0;
    din = 1;
    repeat(50) #10 clk = ~clk;
    din = 8'b0;
    repeat(1500) #10 clk = ~clk;
    #2000;
    $finish;
end
initial begin
	$monitor("Tiempo: %t \n Datos MAC: \n Adder: %d \n Coef: %d \n Salida MAC: %d \n Salida FIR: %d", $time, uut.m1, uut.m2, uut.q1, uut.dout);
end
endmodule

#!/bin/csh
set src = " \
./rtl/adder.v\
./rtl/fir2n_TB.v\
./rtl/asr.v\
./rtl/clkdiv.v\
./rtl/comparador.v\
./rtl/counter_up.v\
./rtl/counter_down.v\
./rtl/fir2n.v\
./rtl/mac.v\
./rtl/register.v\
./rtl/retardo.v\
./rtl/rom.v"


iverilog -o fir2npre $src -v
vvp fir2npre > prelog.log

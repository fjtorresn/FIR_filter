#!/bin/csh
set src = " \
./rtl/fir2n_synth.v\
./rtl/fir2n_TB.v\
./rtl/osu05_stdcells.v"


iverilog -o fir2npre $src -v
vvp fir2npre > postlog.log

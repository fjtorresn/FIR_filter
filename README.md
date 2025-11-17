FIR Filter Project
==================

This project implements a parametrizable FIR filter chip. The filter is designed to exploit symmetry (linear-phase) in the coefficients to reduce the number of required modules and gates.

Parameters
- 2N = N_TAPS: number of coefficients.
- LOG2_N_TAPS: number of address bits to represent N_TAPS.
- WIDTH_DATA: input data width (bits).
- WIDTH_COEF0: coefficient width (bits).
- WIDTH_MAC_OUT: width of the MAC output.

These parameters fully parameterize the filter implementation.

Workflow
- Design parametrized modules
- Pre-synthesis simulation of the full filter
- Logic synthesis
- Post-synthesis verification (simulation)
- Qflow (placement & routing)
- Magic (layout)
- Design characterization

Each step is summarized below.

Design
------

All parametrized modules used to build the filter are available here:
https://github.com/fjtorresn/FIR_filter/tree/main/proyecto/rtl

Testbenches for individual modules are here:
https://github.com/fjtorresn/FIR_filter/tree/main/proyecto/testbench

The main filter implementation (fir2) is here:
https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/PreSynth/iverilog/rtl/fir2n.v

Block diagram
-------------

The design leverages symmetry in the FIR coefficients to minimize hardware. Certain delays between ASR and ADDER, and between MAC and ROM, were removed. With a 15-cycle delay between reset and the MAC, the filter operates such that the clkout runs N_TAPS times slower than the main clock. Using up/down counters to address coefficient symmetry reduces resource usage. Data and coefficients are processed by a MAC unit; registers and delays synchronize the operations.

![diagram](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/bloques.png)

Pre-synthesis Simulation
------------------------

Place all RTL modules in the rtl folder:
https://github.com/fjtorresn/FIR_filter/tree/main/proyecto/PreSynth/iverilog/rtl

Modify run_simulation.csh and run_display.csh to include modules, select the top module, and set a log file. The testbench used for this simulation is:
https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/testbench/fir2n_TB.v

From the PreSynth folder run:
csh run_simulation.csh
csh run_display.csh

The resulting log shows MAC outputs (the MAC performs the filter’s key operation) as well as the overall filter output:
https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/PreSynth/iverilog/prelog.log

Example waveforms
- clkout: N_TAPS times slower than the main clock
- din, dout: filter input and output
- addr1, addr2: up/down counters
- m1, m2: MAC inputs

![presim1](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/pres1.png)
![presim2](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/pres2.png)

Synthesis
---------

Synthesis was performed with Yosys. Place RTL files in the yosys/rtl folder. The flow script (flow.ys) selects modules, the top, and the cell library (05). The synthesis log and resulting synthesized netlist are available here:
- flow log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/yosys/flow.log
- synth.v: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/yosys/synth.v

To run synthesis from the yosys folder:
make

Post-synthesis Verification
---------------------------

For verification, simulate the synthesized netlist together with the standard cell .v file and the original testbench. RTL for post-synthesis verification resides here:
https://github.com/fjtorresn/FIR_filter/tree/main/proyecto/PostSynth/iverilog/rtl

Run:
csh run_simulation.csh
csh run_display.csh

Compare pre- and post-synthesis logs:
https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/PostSynth/iverilog/postlog.log

Example post-synthesis waveforms:
![posts1](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/posts1.png)
![posts2](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/posts2.png)

Qflow (Full ASIC Flow)
----------------------

Run qflow GUI after placing source files in the project source directory and creating layout and synthesis folders:
qflow gui

Set the top module and the target standard cell library (osu050) in the GUI, then run these stages:

- Preparation: prepares files for synthesis. Log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/log/prep.log
  ![prep](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/preparation.png)

- Synthesis: converts RTL to gates using the chosen cell library. Log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/log/synth.log

- Placement: places standard cells on the layout. Log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/log/synth.log
  ![placement1](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/placement.png)
  ![placement2](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/placement2.png)

- Static Timing Analysis (STA): performs timing checks, identifies critical paths, and estimates maximum frequency. Log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/log/sta.log

- Routing: routes interconnects between placed cells. Log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/log/route.log
  ![route](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/route.png)

- Post-route STA: rerun STA with actual routing parasitics. Log: https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/log/post_sta.log
  ![poststa](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/prsta.png)

Magic / GDS generation
----------------------

Generate the layout and GDS using Magic. From the project/Qflow/layout folder run:
cd project/Qflow/layout
magic -dnull -noconsole ./run_drc_fir2n.tcl

This produces the GDS:
https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/Qflow/layout/firn2n.gds
![layout](https://github.com/fjtorresn/FIR_filter/blob/main/proyecto/layout.png)

Characterization
----------------

Key extracted metrics:

- Area: ~185,924 μm^2. Derived from Yosys reported cell area (flow.log, line ~3667) multiplied by 0.25 μm^2 per cell (technology: 0.5 μm).
- Maximum frequency: 182.366 MHz. From post-route STA (post_sta.log, line ~366).
- Supply voltage: 5 V. From the standard cell library (osu05_stdcells.lib, line ~34).
- Cell count: 1,363. From synthesis/simulation reports (flow.log, line ~3647).

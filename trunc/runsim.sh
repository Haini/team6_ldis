#!/bin/bash

rm -f *.o *.cf *.vcd

ghdl -a trunc_pkg.vhd
ghdl -a trunc.vhd
ghdl -a trunc_tb.vhd
ghdl -e trunc_tb
ghdl -r trunc_tb --vcd=wave.vcd --stop-time=10ns

rm -f *.o *.cf


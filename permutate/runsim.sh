#!/bin/bash

rm -f *.o *.cf *.vcd

ghdl -a permutate_pkg.vhd
ghdl -a permutate.vhd
ghdl -a permutate_tb.vhd
ghdl -e permutate_tb
ghdl -r permutate_tb --vcd=wave.vcd --stop-time=10ns

rm -f *.o *.cf


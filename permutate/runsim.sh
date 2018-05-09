#!/bin/bash

rm -f *.o *.cf *.vcd

ghdl -a --std=08 strings_h.vhd
ghdl -a --std=08 permutate_pkg.vhd
ghdl -a --std=08 permutate.vhd
ghdl -a --std=08 permutate_tb.vhd
ghdl -e --std=08 permutate_tb
ghdl -r --std=08 permutate_tb --vcd=wave.vcd --stop-time=10ns

rm -f *.o *.cf


#!/bin/bash

rm -f *.o *.cf *.vcd

ghdl -a --std=08 ../permutate/permutate_pkg.vhd
ghdl -a --std=08 ../permutate/permutate.vhd
ghdl -a --std=08 compress_pkg.vhd
ghdl -a --std=08 compress.vhd
ghdl -a --std=08 compress_tb.vhd
ghdl -e --std=08 compress_tb
ghdl -r --std=08 compress_tb --vcd=wave.vcd --stop-time=50ns --disp-tree=proc

rm -f *.o *.cf


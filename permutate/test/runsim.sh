#!/bin/bash

rm -f *.o *.cf *.vcd

ghdl -a --std=08 test.vhd
ghdl -e --std=08 test
ghdl -r --std=08 test --vcd=wave.vcd --stop-time=10ns

rm -f *.o *.cf


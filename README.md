# Implementation of the following parts for the LDIS Lab @ TU Vienna

## Project Structure

Each component resides in its own folder, each folder contains a `runsim.sh` script
that executes the simulation with the provided \*.txt test vectors.

The folders permutate and compress contain an additional `testgeneration` folder, 
where Python Scripts (>3.5) for the generation / conversion of test vectors reside.

The `./permutation/permutation_pkg.vhd` package holds some vital functions:
- `trunc`, the truncate function
- `f_GB`, the round function
- `f_PERMUTATE`, the permutation function P
 
 
## Extra Info for Project:
Project 2: Engineering

Group 8

Compression Function G:
Memory Map for Matrix must be defined.


G6 and G5 need to figure out together for the Memory Map.


Group 8 need Specification of API/Input Output


Should be probably same lenght

13 bits Adresses - should use 12 bits
B[i][j] -> lenght T for j = 0,1
								is 1024 bytes for others.
						Start Adress of Segment is given by formula: (256*i+j)*1024 ---> Adress Map for big Matrix B
						
2²⁶ is space on hardware.
2²⁰ adresses to fill the matrix needed.



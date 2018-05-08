# Implementation of the following parts for the LDIS Lab @ TU Vienna

## (a) Implement steps 5-8 of Section 3.2 in [1]

5. Compute B[i][j] for all i ranging from (and including) 0 to (not
 including) p, and for all j ranging from (and including) 2) to
 (not including) q. The block indices i’ and j’ are determined
 for each i, j differently for Argon2d, Argon2i, and Argon2id
 (Section Section 3.4).
 B[i][j] = G(B[i][j-1], B[i’][j’])
 Further block generation

 6. If the number of iterations t is larger than 1, we repeat the
 steps however replacing the computations with the following
 expression:
 B[i][0] = G(B[i][q-1], B[i’][j’])
 B[i][j] = G(B[i][j-1], B[i’][j’])
 Further passes

7. After t steps have been iterated, the final block C is computed
 as the XOR of the last column:
 C = B[0][q-1] XOR B[1][q-1] XOR ... XOR B[p-1][q-1]
 Final block

 8. The output tag is computed as H’(C).

## (b) Implement compression function G of section 3.5 in [1]

Compression function G
 Compression function G is built upon the BLAKE2b round function P. P
 operates on the 128-byte input, which can be viewed as 8 16-byte
 registers:
 P(A_0, A_1, ... ,A_7) = (B_0, B_1, ... ,B_7)
 Blake round function P
 Compression function G(X, Y) operates on two 1024-byte blocks X and
 Y. It first computes R = X XOR Y. Then R is viewed as a 8x8 matrix
 of 16-byte registers R_0, R_1, ... , R_63. Then P is first applied
 to each row, and then to each column to get Z:
 ( Q_0, Q_1, Q_2, ... , Q_7) <- P( R_0, R_1, R_2, ... , R_7)
 ( Q_8, Q_9, Q_10, ... , Q_15) <- P( R_8, R_9, R_10, ... , R_15)
 ...
 (Q_56, Q_57, Q_58, ... , Q_63) <- P(R_56, R_57, R_58, ... , R_63)
 ( Z_0, Z_8, Z_16, ... , Z_56) <- P( Q_0, Q_8, Q_16, ... , Q_56)
 ( Z_1, Z_9, Z_17, ... , Z_57) <- P( Q_1, Q_9, Q_17, ... , Q_57)
 ...
 ( Z_7, Z_15, Z 23, ... , Z_63) <- P( Q_7, Q_15, Q_23, ... , Q_63)
 Core of compression function G
 Finally, G outputs Z XOR R:
 G: (X, Y) -> R -> Q -> Z -> Z XOR R

## (c) Implement permutation P of section 3.6 in [1]

Permutation P is based on the round function of BLAKE2b. The 8
 16-byte inputs S_0, S_1, ... , S_7 are viewed as a 4x4 matrix of
 64-bit words, where S_i = (v_{2*i+1} || v_{2*i}):
 v_0 v_1 v_2 v_3
 v_4 v_5 v_6 v_7
 v_8 v_9 v_10 v_11
 v_12 v_13 v_14 v_15
 Matrix element labeling
 It works as follows:

GB(v_0, v_4, v_8, v_12)
 GB(v_1, v_5, v_9, v_13)
 GB(v_2, v_6, v_10, v_14)
 GB(v_3, v_7, v_11, v_15)
 GB(v_0, v_5, v_10, v_15)
 GB(v_1, v_6, v_11, v_12)
 GB(v_2, v_7, v_8, v_13)
 GB(v_3, v_4, v_9, v_14)
 Feeding matrix elements to GB
 GB(a, b, c, d) is defined as follows:
 a = (a + b + 2 * trunc(a) * trunc(b)) mod 2^(64)
 d = (d XOR a) >>> 32
 c = (c + d + 2 * trunc(c) * trunc(d)) mod 2^(64)
 b = (b XOR c) >>> 24
 a = (a + b + 2 * trunc(a) * trunc(b)) mod 2^(64)
 d = (d XOR a) >>> 16
 c = (c + d + 2 * trunc(c) * trunc(d)) mod 2^(64)
 b = (b XOR c) >>> 63
 Details of GB
 The modular additions in GB are combined with 64-bit multiplications.
 Multiplications are the only difference to the original BLAKE2b
 design. This choice is done to increase the circuit depth and thus
 the running time of ASIC implementations, while having roughly the
 same running time on CPUs thanks to parallelism and pipelining.

## (d) Implement the trunc(a) function

trunc(a) --- the 64-bit value a truncated to the 32 least significant
 bits
 
 
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



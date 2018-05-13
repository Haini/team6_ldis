# Testcase Generation for Permutation Function

The intended solution was to refactor the C-Reference solution of the argon2
algorithm. The refactoring would include the extraction of testvectors and results 
at key points. 
The following steps are used to create the testvectors for the permutation function:

- `git clone https://github.com/P-H-C/phc-winner-argon2.git`
- Edit the `src/blake2/blake2b.c` file
- Insert `printfs` to extract the array `v[]` before and after it is altered by the
  permutation function `G(..)` in the `ROUND(r)` function
- Run `echo -n "password" | ./argon2 somesalt -t 1 -m 16 -p 1 -l 24 > test.txt`
- `cat test.txt` should look like this (16 times 64bit integers as input, 16 times 64bit integers
  as output):
```INPUTSTART
7640891576939301192
13503953896175478587
...
16175846103906665108
6620516959819538809
INPUTEND
OUTPUTSTART
1077841513086185864
5048975119375164137
...
3512903622607548045
18317641220188230422
OUTPUTEND```

But as it turns out the actual argon2 implementation deviates from the reference
implementation in the file `src/blake2/blamka-round-ref.h`.
As it was easy to replace the actually used code with the reference code a 
comparison between the two versions was done. 
First and most notably the `make test` command to verify the correctness of the
solution failed with the reference solution. 
Second the reference solution matched the output of our own VHDL implementation
perfectly. Then the algorithm from the draft was implemented in `Python3.5` to 
get another set of data points. As expected the `Python3.5` implementation did match both,
the reference and the VHDL implementation. 

As the actual live code differs from the suggested algorithm in the irtf draft and yields
different results than the three other sets of code, no assumption about the correctness
of the permutation function P in section 3.6 can be made.
\begin{center}
\begin{tabular}{ c | c c c c}
Input & Python3.5 & VHDL & C Reference & C Actual \\ 
\hline
 6A09E667F2BDC948 & 4B86FAA34237F816 & 4B86FAA34237F816 & 4B86FAA34237F816 & 3D9D014CA238A25D\\  
 510E527FADE682D1 & 826371B4B7CF06DB & 826371B4B7CF06DB & 826371B4B7CF06DB & D9CE83A69663A233\\
 6A09E667F3BCC908 & 6915F3A835F68E52 & 6915F3A835F68E52 & 6915F3A835F68E52 & B8023558C91686D7\\  
 510E527FADE682E9 & 4A645E346BE317D8 & 4A645E346BE317D8 & 4A645E346BE317D8 & 2E207F7532A740EC   
\end{tabular}
\end{center}

After analysing the Makefile in more detail the culprit for the deviation of 
the results was found: 

```
OPTTEST := $(shell $(CC) -Iinclude -Isrc -march=$(OPTTARGET) src/opt.c -c \
			-o /dev/null 2>/dev/null; echo $$?)
# Detect compatible platform
ifneq ($(OPTTEST), 0)
$(info Building without optimizations)
	SRC += src/ref.c
else
$(info Building with optimizations for $(OPTTARGET))
	CFLAGS += -march=$(OPTTARGET)
	SRC += src/opt.c
endif

```

The Makefile checks if it can build an optimized version for the current architecture and
if it is able to do so, it will. Somehow this observation slipped the first few times of
looking at the Makefile, probably due to the fact that the understanding of the code
structure wasn't very good at that point.

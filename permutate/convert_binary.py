"""
PYVERSION: Only tested with 3.5
AUTHOR: Constantin Schieber, 1228774
MAIL: Constantin.Schieber@outlook.com
PURPOSE: This script converts 64Bit Unsigned Integers into its 64 Bit binary
representation and saves the converted numbers to a new file. Usefull for VHDL
"""

# Open the file
with open("file_in.txt") as f:
	
	#Iterate over all lines in the file and convert
	for line in f: 
		conv_val = '{0:064b}'.format(int(line))
		
		#TODO: Don't open and close the file on every read.
		with open("testvector_bin.txt", 'a') as fb:
			print(conv_val)
			fb.write(conv_val)
			fb.write('\n')
		fb.closed
f.closed

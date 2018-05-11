#
# Rotates a Number num logically right by count bits
# Works well with 64 bits 
# Returns the number as integer
#
"""
---PYVERSION: Only tested with 3.5
---AUTHOR: Constantin Schieber, 1228774
---MAIL: Constantin.Schieber@outlook.com
---PURPOSE: 
"""

#@brief binary rotate right
#			Rotates a number num by count bits right
#			Implementation based on binary string representation and
#			manipulation
#@param num Number that shall be rotated to the right
#@param bits Number of shifts ro right
def bror(num, bits):
	b = bits 
	#print("B IS: " + str(b))
	snum = str('{:064b}'.format(num))
	#print("SNUM: " + snum + " | LAST: " + snum[15] + " | FIRST: " + snum[0])
	tmp = snum[0 : 64-b]
	tmp2 = snum[64-b : 64]
	#print("TMP1 : " + tmp)
	#print("TMP2 : " + tmp2)
	return int(tmp2 + tmp, 2)

#@brief ROUND Function of blake2b 
#			Works as described in section 3.6 in the irtf-cfrg-argon2 draft	
#@returns [a,b,c,d] Array of manipulated values
def f_GB(a,b,c,d):

	a = (a  + b + 2 * (a& int(0xFFFFFFFF)) * (b& int(0xFFFFFFFF))) % int(0x8000000000000000)
	d = bror(d^a,32)
	c = (c  + d + 2 * (c& int(0xFFFFFFFF)) * (d& int(0xFFFFFFFF))) % int(0x8000000000000000)
	b = bror(b^c,24)

	a = (a  + b + 2 * (a& int(0xFFFFFFFF)) * (b& int(0xFFFFFFFF))) % int(0x8000000000000000)
	d = bror(d ^ a,16) 
	c = (c  + d + 2 * (c& int(0xFFFFFFFF)) * (d& int(0xFFFFFFFF))) % int(0x8000000000000000)
	b = bror(b ^ c,63)

	return [a,b,c,d]


with open("testvector_bin.txt", 'r') as f:
	i = 0
	v = []
	testset_count = 0
	for line in f:
		v.append(int(line,2))
		i+=1
		if (i % 16) == 0:
			for i in range(4):
				print("V["+str(0+i)+"]: " + '{:016X}'.format(v[0+i]))
				print("V["+str(4+i)+"]: " + '{:016X}'.format(v[4+i]))
				print("V["+str(8+i)+"]: " + '{:016X}'.format(v[8+i]))
				print("V["+str(12+i)+"]: " + '{:016X}'.format(v[12+i]))
				v_tmp = f_GB(v[0+i],v[4+i],v[8+i],v[12+i])
				v[0+i] = v_tmp[0] 
				v[4+i] = v_tmp[1] 
				v[8+i] = v_tmp[2] 
				v[12+i]= v_tmp[3]
				print("V["+str(0+i)+"]: " + '{:016X}'.format(v[0+i]))
				print("V["+str(4+i)+"]: " + '{:016X}'.format(v[4+i]))
				print("V["+str(8+i)+"]: " + '{:016X}'.format(v[8+i]))
				print("V["+str(12+i)+"]: " + '{:016X}'.format(v[12+i]))
				print("==============================================")

			v_tmp = f_GB(v[0], v[5], v[10], v[15]);
			v[0] 	= v_tmp[0]; 
			v[5] 	= v_tmp[1];
			v[10] 	= v_tmp[2];
			v[15] 	= v_tmp[3];

			v_tmp = f_GB(v[1], v[6], v[11], v[12]);
			v[1] 	= v_tmp[0]; 
			v[6] 	= v_tmp[1];
			v[11] 	= v_tmp[2];
			v[12] 	= v_tmp[3];

			v_tmp = f_GB(v[2], v[7], v[8], v[13]);
			v[2] 	= v_tmp[0]; 
			v[7] 	= v_tmp[1];
			v[8] 	= v_tmp[2];
			v[13] 	= v_tmp[3];

			v_tmp = f_GB(v[3], v[4], v[9], v[14]);
			v[3] 	= v_tmp[0]; 
			v[4] 	= v_tmp[1];
			v[9] 	= v_tmp[2];
			v[14] 	= v_tmp[3];
 
			with open("bin_self_result.txt", 'a') as fa:
				for j in range(16):
					fa.write('{0:064b}'.format(int(v[j])))
					fa.write('\n')
			fa.closed
			
			# Finished reading one set of inputs
			# and writing own results into test file
			i = 0
			v = []
			if testset_count >= 10:
				print("Exiting generation")
				break
			else:
				for useless_lines in range(16):
					f.readline()
				testset_count+=1
f.closed

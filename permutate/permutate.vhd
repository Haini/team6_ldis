--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Implementation for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6 
--
-- SUMMARY: Input is either one row or column of 8 16-bytes registers in form of
-- a 128*8 wide std_logic_vector.
-- Output is of the same format, but with the permutation function GB applied.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.permutate_pkg.all;
--
--------------------------------------------------------------------------------
--
entity permutate is
	
	port(
		i_S	: in std_logic_vector(128*8-1 downto 0);
		o_S	: out std_logic_vector(128*8-1 downto 0)
	);

end permutate;
--
--------------------------------------------------------------------------------
--
architecture beh of permutate is

	--Debug Signals--
	signal debug_vres : blockR(0 to 15);
	signal debug_vin : std_logic_vector(63 downto 0);

begin

	permutation: process(i_S)
		--help variables for the permutation process
		variable v_tmp  : blockR(0 to 3);
		variable v_res : blockR(0 to 15); 
		variable offs : integer range 0 to 16;
	begin
		
		report "***Starting Calculations***";		
		for i in 0 to 15 loop
			v_res(15-i) := i_S((i+1)*64-1 downto i*64);
		end loop;
		for i in 0 to 3 loop
			report "V["&to_string(0+i)&"]: "&to_hstring(v_res(0+i));
			report "V["&to_string(4+i)&"]: "&to_hstring(v_res(4+i));
			report "V["&to_string(8+i)&"]: "&to_hstring(v_res(8+i));
			report "V["&to_string(12+i)&"]: "&to_hstring(v_res(12+i));
			v_tmp := f_GB(v_res(0+i), v_res(4+i), v_res(8+i), v_res(12+i));
			v_res(0+i) 		:= v_tmp(0); 
			v_res(4+i) 		:= v_tmp(1);
			v_res(8+i) 		:= v_tmp(2);
			v_res(12+i) 	:= v_tmp(3);
			report "V["&to_string(0+i)&"]: "&to_hstring(v_res(0+i));
			report "V["&to_string(4+i)&"]: "&to_hstring(v_res(4+i));
			report "V["&to_string(8+i)&"]: "&to_hstring(v_res(8+i));
			report "V["&to_string(12+i)&"]: "&to_hstring(v_res(12+i));
			report "=============================================";
		end loop;

		

		v_tmp := f_GB(v_res(0), v_res(5), v_res(10), v_res(15));
		v_res(0) 	:= v_tmp(0); 
		v_res(5) 	:= v_tmp(1);
		v_res(10) 	:= v_tmp(2);
		v_res(15) 	:= v_tmp(3);
		debug_vres <= v_res;

		v_tmp := f_GB(v_res(1), v_res(6), v_res(11), v_res(12));
		v_res(1) 	:= v_tmp(0); 
		v_res(6) 	:= v_tmp(1);
		v_res(11) 	:= v_tmp(2);
		v_res(12) 	:= v_tmp(3);

		v_tmp := f_GB(v_res(2), v_res(7), v_res(8), v_res(13));
		v_res(2) 	:= v_tmp(0); 
		v_res(7) 	:= v_tmp(1);
		v_res(8) 	:= v_tmp(2);
		v_res(13) 	:= v_tmp(3);

		v_tmp := f_GB(v_res(3), v_res(4), v_res(9), v_res(14));
		v_res(3) 	:= v_tmp(0); 
		v_res(4) 	:= v_tmp(1);
		v_res(9) 	:= v_tmp(2);
		v_res(14) 	:= v_tmp(3);



		--for i in 0 to 3 loop
		--	offs := i*4;
		--	v_in(0) := (i_S(((128*8-1)-((offs+0)*64)) downto ((128*8-1)-((offs+1)*64)+1)));
		--	v_in(1) := (i_S(((128*8-1)-((offs+1)*64)) downto ((128*8-1)-((offs+2)*64)+1)));
		--	v_in(2) := (i_S(((128*8-1)-((offs+2)*64)) downto ((128*8-1)-((offs+3)*64)+1)));
		--	v_in(3) := (i_S(((128*8-1)-((offs+3)*64)) downto ((128*8-1)-((offs+4)*64)+1)));

		--	debug_vin <= v_in(0);	

		--	v_res((0 + i*4) to (3 + i*4)) := f_GB(v_in);
		--	
		--end loop;

		o_S <= v_res(0) & v_res(1) & v_res(2) & v_res(3) & v_res(4) &
				 v_res(5) & v_res(6) & v_res(7) & v_res(8) & v_res(9) &
				 v_res(10) & v_res(11) & v_res(12) & v_res(13) & v_res(14) &
				 v_res(15);

	-- >>> Means in this context a rotation of 64 bit string to the right
	--by n bits
	
	end process;
end beh;


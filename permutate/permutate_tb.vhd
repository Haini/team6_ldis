--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Testbench for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6
-- To be more precise, this is the round function, used by the permutation function
--
--https://github.com/autosub-team/autosub/blob/autosub_devel/tasks/implementation/VHDL/blockcode/templates/testbench_template.vhdl 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use work.permutate_pkg.all;
--
--------------------------------------------------------------------------------
--
entity permutate_tb is
end permutate_tb;
--
--------------------------------------------------------------------------------
--
architecture permutate_tb of permutate_tb is

	-- function to print std_logic_vectors
    function Image(In_Image : Std_Logic_Vector) return String is
        variable L : Line;  -- access type
        variable W : String(1 to In_Image'length) := (others => ' ');
    begin
         WRITE(L, In_Image);
         W(L.all'range) := L.all;
         Deallocate(L);
         return W;
    end Image;	

	signal i_S_duv :	std_logic_vector(128*8-1 downto 0);
	signal o_S_duv :	std_logic_vector(128*8-1 downto 0);
	
	subtype by_te is character;
	type f_byte is file of by_te;

begin

	DUV : entity work.permutate
		
		port map(
			i_S => i_S_duv,	
			o_S	=> o_S_duv
		); 
  

	test: process
		variable line_v 	: line;
		variable line_read 	: std_logic_vector(63 downto 0);
		file read_file 		: text;
		file read_file2		: text;

		variable slv_v 		: std_logic_vector(128*8-1 downto 0) := (others => '0');	
		variable slv_assert : std_logic_vector(128*8-1 downto 0) := (others => '0');	
		
	begin
	
	file_open(read_file, "testvector_bin.txt", read_mode);
	file_open(read_file2, "bin_self_result.txt", read_mode);

	for testruns in 0 to 6 loop
		-- Loop over the file lines and save each line (one v_X) to the 
		-- big input vector.
		-- One should check the correct order of the registers within the vector
		for i in 0 to 15 loop
			readline(read_file, line_v);
			read(line_v, line_read);
			
			slv_v((128*8-1)-(i*64) downto ((128*8-1)-(64*(i+1))+1)) := line_read;
		end loop;

		-- Skip the output from the C Argon2 Implementation...
		for ii in 0 to 15 loop
			readline(read_file, line_v);
		end loop;
		
		-- ...and use the output from the python implementation instead
		for i in 0 to 15 loop
			readline(read_file2, line_v);
			read(line_v, line_read);

			slv_assert((128*8-1)-(i*64) downto ((128*8-1)-(64*(i+1))+1)) := line_read;
		end loop;

		report "TO ASSERT: " & to_hstring(slv_assert(128*8-1 downto 128*7));
		report "InputVector is: " & to_hstring(slv_v(128*8-1 downto 128*7));

-- Reading data end
--
--------------------------------------------------------------------------------
--
-- The real testing starts here
	
		wait for 1 ns;
		report "Assigning signal... " & to_hstring(slv_v(128*8-1 downto 128*7));
		i_S_duv <= slv_v;
		report "Assigned signal...";
		wait for 2 ns;
		assert o_S_duv = slv_assert report "Output Vector didn't match precomputed output Vector!"& LF &
		to_hstring(o_S_duv) & LF & to_hstring(slv_assert)
		severity FAILURE;

		assert o_S_duv /= slv_assert report "TEST PASSED" severity NOTE;

	end loop;	
	file_close(read_file);
	file_close(read_file2);
		wait;
	end process test;
	
end permutate_tb;


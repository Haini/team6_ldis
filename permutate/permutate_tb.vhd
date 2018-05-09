--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Testbench for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6
--
--https://github.com/autosub-team/autosub/blob/autosub_devel/tasks/implementation/VHDL/blockcode/templates/testbench_template.vhdl 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

use work.permutate_pkg.all;
use work.strings_h.all;
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
  
	--clk_gen : process
	--begin
	--end process clk_gen;

	test: process
		variable line_v : line;
		file read_file : text;
		file write_file : text;
		variable slv_v : std_logic_vector(128*8-1 downto 0) := (others => '0');	
		variable readInt : integer := 0;	
		
		constant file_name: string :="testvector_small.txt";
		file in_file: f_byte open read_mode is file_name;
		variable a: character;
		
	begin

		for i in 0 to 15 loop
			for i in 0 to 23 loop
			exit when a = character'val(10);
				if not endfile (in_file) then
					read(in_file, a);
					if a = character'val( 10 ) then --check if newline
						report "Found newline";			
					end if;
					report "SLV: " & to_string(a);
				end if;
			end loop;
			a := '0';
		end loop;
	
	
	
		--file_open(read_file, "testvector_small.txt", read_mode);
		--file_open(write_file, "testvector_small_out.txt", write_mode);
		----while not endfile(read_file) loop 
			--report "SLV_START: " & to_hstring(slv_v);
			--readline(read_file, line_v);
				--for i in 0 to 15 loop
					--readline(read_file, line_v);
					----writeline(write_file, line_v);
					----read(line_v, readInt);
					--read(line_v, readInt);
					----report "SLV1: " & to_string(readInt);
					--report "SLV: " & to_string(std_logic_vector(to_unsigned(readInt,slv_v'length)));
					--wait for 1 ns;
				--end loop;
		----end loop;

		wait for 1 ns;
		i_S_duv <= (others => '0');
		wait for 1 ns;

		assert i_S_duv = (128*8-1 downto 0 => '0') report "Input 0 does not result in Output 0!"
		severity FAILURE;

		report "TEST PASSED" severity NOTE;

		wait;
	end process test;
	
end permutate_tb;


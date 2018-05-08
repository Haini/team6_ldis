--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Testbench for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
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
	
	signal i_S_duv :	std_logic_vector(128*8-1 downto 0);
	signal o_S_duv :	std_logic_vector(128*8-1 downto 0);

begin

	DUV : entity work.permutate
		
		port map(
			i_S => i_S_duv,	
			o_S	=> o_S_duv
		); 
  
	clk_gen : process
	begin
	end process clk_gen;

	test: process
	begin
		i_S_duv <= (others => '0');

		wait for 1 ns;

		assert i_S_duv = (128*8-1 downto 0 => '0') report "Input 0 does not result in Output 0!"
		severity FAILURE;
		report "TEST PASSED" severity NOTE;
	end process test;
	
end permutate_tb;


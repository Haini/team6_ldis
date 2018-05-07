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
	

begin

	DUV : entity work.permutate

		port map(
		); 
  
	clk_gen : process
	begin
	end process clk_gen;

	test: process
	begin
		report "TEST PASSED" severity NOTE;
	end process test;
	
end permutate_tb;


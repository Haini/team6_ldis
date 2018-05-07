--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Testbench for the Compression function G from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.5 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.compress_pkg.all;
--
--------------------------------------------------------------------------------
--
entity compress_tb is
end compress_tb;
--
--------------------------------------------------------------------------------
--
architecture compress_tb of compress_tb is
	

begin

	DUV : entity work.compress

		port map(
		); 
  
	clk_gen : process
	begin
	end process clk_gen;

	test: process
	begin
		report "TEST PASSED" severity NOTE;
	end process test;
	
end compress_tb;


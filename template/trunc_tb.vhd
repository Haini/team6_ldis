--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Testbench for the trunc function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 2
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.trunc_pkg.all;
--
--------------------------------------------------------------------------------
--
entity trunc_tb is
end trunc_tb;
--
--------------------------------------------------------------------------------
--
architecture trunc_tb of trunc_tb is
	

begin

	DUV : entity work.uart_tx
		generic map(
		)

		port map(
		); 
  
	clk_gen : process
	begin
	end process clk_gen;

	test: process
	begin
		report "TEST PASSED" severity NOTE;
	end process test;
	
end trunc_tb;


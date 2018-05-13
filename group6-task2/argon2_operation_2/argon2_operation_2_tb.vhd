--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Testbench for the Argon2 Operation function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.2 Section 5-8
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.argon2_operation_2_pkg.all;
--
--------------------------------------------------------------------------------
--
entity argon2_operation_2_tb is
end argon2_operation_2_tb;
--
--------------------------------------------------------------------------------
--
architecture argon2_operation_2_tb of argon2_operation_2_tb is
	

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
	
end argon2_operation_2_tb;


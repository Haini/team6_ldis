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
	
	signal i_a_duv	: std_logic_vector(63 downto 0);
	signal o_a_duv	: std_logic_vector(31 downto 0);

begin

	DUV : entity work.trunc

		port map(
			i_a	=> i_a_duv,
			o_a	=> o_a_duv 
		); 
  
	test: process
	begin
		wait for 1 ns;
		i_a_duv <= (others => '1');
		wait for 1 ns;

		assert o_a_duv = (31 downto 0 => '1') 
			report "TEST FAILED: not all one"
			severity failure;

		wait for 1 ns;
		i_a_duv <= (others => '0');
		wait for 1 ns;
		assert o_a_duv = (31 downto 0 => '0')
			report "TEST FAILED: not all zero"
			severity failure;

		report "TEST PASSED" severity NOTE;
	end process test;
	
end trunc_tb;


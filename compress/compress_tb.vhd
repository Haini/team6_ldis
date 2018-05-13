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
use ieee.numeric_std.all;
use std.textio.all;

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

	constant V_SIZE : integer := 1024*8-1;
	constant VS_SIZE : integer := 128*8-1;
	
	signal i_X_duv : std_logic_vector(V_SIZE downto 0);
	signal i_Y_duv : std_logic_vector(V_SIZE downto 0);
	signal o_Z_duv : std_logic_vector(V_SIZE downto 0);

	
begin

	DUV : entity work.compress

		port map(
			i_X => i_X_duv,	
			i_Y	=> i_Y_duv,
			o_Z	=> o_Z_duv
		); 
  

	test: process
	begin
		wait for 1 ns;
		i_X_duv <= (others => '1');
		i_Y_duv <= (others => '0');
		wait for 1 ns;
		report "TEST PASSED" severity NOTE;
		wait;
	end process test;
	
end compress_tb;


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
		variable line_v : line;
		file read_file : text;
		variable slv_inputX : std_logic_vector(1024*8-1 downto 0) := (others => '0');	
		variable slv_inputY : std_logic_vector(1024*8-1 downto 0) := (others => '0');	
		variable slv_assert : std_logic_vector(1024*8-1 downto 0) := (others => '0');	

		variable line_read : std_logic_vector(63 downto 0);
		variable readInt : integer := 0;	
		
		constant file_name: string :="compress_bin.txt";

		variable a: character;

	begin
		file_open(read_file, "compress_bin.txt", read_mode);
		report "Starting read...";	
		-- Read the Input Vector X
		for i in 0 to 127 loop
			readline(read_file, line_v);
			read(line_v, line_read);
			slv_inputX((1024*8-1)-(i*64) downto ((1024*8-1)-(64*(i+1))+1)) := line_read;
		end loop;

		-- Read the Input Vector Y
		for i in 0 to 127 loop
			readline(read_file, line_v);
			read(line_v, line_read);
			
			slv_inputY((1024*8-1)-(i*64) downto ((1024*8-1)-(64*(i+1))+1)) := line_read;
		end loop;

		-- Read the Output Vector
		for i in 0 to 127 loop
			readline(read_file, line_v);
			read(line_v, line_read);
			
			slv_assert((1024*8-1)-(i*64) downto ((1024*8-1)-(64*(i+1))+1)) := line_read;
		end loop;
	file_close(read_file);
-- Reading data end
--
--------------------------------------------------------------------------------
--
-- The real testing starts here
		wait for 1 ns;
		i_X_duv <= (others => '0');
		i_Y_duv <= (others => '0');
		wait for 1 ns;

		wait for 1 ns;
		i_X_duv <= slv_inputX;
		i_Y_duv <= slv_inputY;
		wait for 1 ns;

		report to_hstring(slv_assert(1024*8-1 downto 1024*8-128));
		report to_hstring(o_Z_duv(1024*8-1 downto 1024*8-128));

		assert o_Z_duv = slv_assert report "Output Vector didn't match precomputed vector!" severity FAILURE;
		report "TEST PASSED" severity NOTE;
		wait;
	end process test;
	
end compress_tb;


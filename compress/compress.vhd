--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Implementation for the Compression function G from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.5 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.permutate_pkg.all;
--
--------------------------------------------------------------------------------
--
entity compress is
	
	port(
		i_X : in std_logic_vector(1024*8-1 downto 0);
		i_Y : in std_logic_vector(1024*8-1 downto 0);
		o_Z : in std_logic_vector(1024*8-1 downto 0)
	);

end compress;
--
--------------------------------------------------------------------------------
--
architecture beh of compress is


	constant V_SIZE : integer := 1024*8-1;
	constant VS_SIZE : integer := 128*8-1;


	--Operate on smaller X,Y sizes, do more sequential stuff instead
	signal small_X 	: std_logic_vector(VS_SIZE downto 0);
	signal small_Y 	: std_logic_vector(VS_SIZE downto 0);
	signal i_S 		: std_logic_vector(VS_SIZE downto 0);
	signal o_S 		: std_logic_vector(VS_SIZE downto 0);

begin

	en_permutate : entity work.permutate
		
		port map(
			i_S => i_S,	
			o_S	=> o_S
		); 

	compress : process(i_X, i_Y, o_S)
		variable R : std_logic_vector(V_SIZE downto 0);
		variable X : std_logic_vector(V_SIZE downto 0) := i_X; 
		variable Y : std_logic_vector(V_SIZE downto 0) := i_Y; 
		variable s_X : std_logic_vector(VS_SIZE downto 0);
		variable s_Y : std_logic_vector(VS_SIZE downto 0);
		variable COL : std_logic_vector(VS_SIZE downto 0);
		variable j : integer range 0 to 56;
	begin

		-- 1.) Do X XOR Y
		R := X xor Y;

		-- 2.) Permutate Resulting R0...R7
		-- 2.1) Permutate Rows
		for i in 0 to 7 loop
			i_S <= R(V_SIZE - 128*8*i downto V_SIZE - 128*8*(i+1)+1);
			R(V_SIZE - 128*8*i downto V_SIZE - 128*8*(i+1)+1) := o_S;
		end loop;

		-- 2.2) Permutate Columns
		for ii in 0 to 7 loop
			for i in 0 to 7 loop
				report to_string(V_SIZE-1024*ii-i*16*8) & " | " & to_string(V_SIZE-1024*ii-16*8-(i*16*8)+1);
				COL(VS_SIZE - 16*8*i downto VS_SIZE - 16*8*(i+1)+1) := 
					R(V_SIZE-1024*ii-i*16*8 downto V_SIZE-1024*ii-16*8-(i*16*8)+1);
			end loop;

			-- Calculate the Permutation
			i_S <= COL;
			COL := o_S; 
			report to_string(COL);

			-- Rewrite Columns with result 
			for i in 0 to 7 loop
				R(V_SIZE-1024*ii-i*16*8 downto V_SIZE-1024*ii-16*8-(i*16*8)+1) :=
							COL(VS_SIZE - 16*8*i downto VS_SIZE - 16*8*(i+1)+1); 
			end loop;
		end loop;
		--for ii in 0 to 7 loop

		--	-- Fill COL with one Column
		--	for i in 0 to 7 loop
		--		report to_string(VS_SIZE - 16*8*i) & " | " & to_string(VS_SIZE - 16*8*(i+1)+1);
		--		report to_string(V_SIZE - 16*8*(j + i)) & " | " & to_string(V_SIZE - 16*8*(j + i+1));
		--		COL(VS_SIZE - 16*8*i downto VS_SIZE - 16*8*(i+1)+1) := 
		--				R(V_SIZE - 16*8*(j+i) downto V_SIZE - 16*8*(j+i+1));
		--	end loop;

		--	-- Calculate the Permutation
		--	i_S <= COL;
		--	COL := o_S; 

		--	-- Rewrite Columns with result 
		--	for i in 0 to 7 loop
		--		R(V_SIZE - 16*8*(j + i) downto V_SIZE - 16*8*(j + i+1)) :=
		--					COL(VS_SIZE - 16*8*i downto VS_SIZE - 16*8*(i+1)); 
		--	end loop;

		--	-- Go one Column to the right
		--	j := j+8;
		--end loop;

	end process;

end beh;


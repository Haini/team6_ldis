--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Package for the Argon2 Operation function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.2 Section 5-8
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
package argon2_operation_2_pkg is
	
	component argon2_operation_2 is

		generic(
			DEG_OF_PARALLELISM  : integer := 4;
			MAX_TAG_LEN_BYTE    : integer := 1024;
			MAX_ITERATION_COUNT : integer := 1e6
		);

		port(
			enable_part1	: in std_logic;
			memory	: inout std_logic_vector(128*8-1 downto 0)
		);

	end component argon2_operation_2;

end argon2_operation_2_pkg;


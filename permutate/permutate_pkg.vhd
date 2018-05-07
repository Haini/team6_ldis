--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Package for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
package permutate_pkg is
	
	component permutate is

		port(
			i_S	: in std_logic_vector(128-1 downto 0);
			o_S	: out std_logic_vector(128-1 downto 0)
		);

	end component permutate;

end permutate_pkg;


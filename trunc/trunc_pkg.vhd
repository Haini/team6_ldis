--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Package for the trunc function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 2
--
-- Summary: Return the 32 least significant bytes of a 64 Bit Input
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
package trunc_pkg is
	
	component trunc is

		port(
			i_a	: in std_logic_vector(63 downto 0);
			o_a	: out std_logic_vector(31 downto 0)
		);

	end component trunc;

end trunc_pkg;


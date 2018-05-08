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
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
package permutate_pkg is

	function trunc (constant a : unsigned(63 downto 0)) return unsigned;
	
	component permutate is

		port(
			i_S	: in std_logic_vector(128*8-1 downto 0);
			o_S	: out std_logic_vector(128*8-1 downto 0)
		);

	end component permutate;

end permutate_pkg;

package body permutate_pkg is
	function trunc (constant a : unsigned(63 downto 0)) return unsigned is
	begin
		return a(31 downto 0);
	end;
end permutate_pkg;


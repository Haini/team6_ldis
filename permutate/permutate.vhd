--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Implementation for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
entity permutate is

	port(
		i_S	: in std_logic_vector(128-1 downto 0);
		o_S	: out std_logic_vector(128-1 downto 0)
	);

end permutate;
--
--------------------------------------------------------------------------------
--
architecture beh of permutate is
begin
end beh;


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
--
--------------------------------------------------------------------------------
--
entity compress is

	port(
		i_X : in std_logic_vector(1023 downto 0);
		i_Y : in std_logic_vector(1023 downto 0);
	);

end compress;
--
--------------------------------------------------------------------------------
--
architecture beh of compress is
begin
end beh;


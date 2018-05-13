--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Package for the compress function G from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.5 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
package compress_pkg is
	
	component compress is

		port(
			i_X : in std_logic_vector(1024*8-1 downto 0);
			i_Y : in std_logic_vector(1024*8-1 downto 0);
			o_Z : in std_logic_vector(1024*8-1 downto 0)
		);

	end component compress;

end compress_pkg;


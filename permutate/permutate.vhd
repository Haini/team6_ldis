--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Implementation for the permutate function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.6 
--
-- SUMMARY: Input is either one row or column of 8 16-bytes registers in form of
-- a 128*8 wide std_logic_vector.
-- Output is of the same format, but with the permutation function GB applied.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.permutate_pkg.all;
--
--------------------------------------------------------------------------------
--
entity permutate is
	
	port(
		i_S	: in std_logic_vector(128*8-1 downto 0);
		o_S	: out std_logic_vector(128*8-1 downto 0)
	);

end permutate;
--
--------------------------------------------------------------------------------
--
architecture beh of permutate is
	constant long_bit : unsigned(63 downto 0)
	:= "1000000000000000000000000000000000000000000000000000000000000000";	
begin

	permutation: process(i_S)
		--help variables for the permutation process
		variable a : unsigned(64-1 downto 0) := (others => '0');
		variable b : unsigned(64-1 downto 0) := (others => '0');
		variable c : unsigned(64-1 downto 0) := (others => '0');
		variable d : unsigned(64-1 downto 0) := (others => '0');
		variable offs : integer range 0 to 16;
	begin
		for i in 0 to 3 loop
			offs := i*4;
			a := unsigned(i_S(((128*8-1)-((offs+0)*64)) downto ((128*8-1)-((offs+1)*64)+1)));
			b := unsigned(i_S(((128*8-1)-((offs+1)*64)) downto ((128*8-1)-((offs+2)*64)+1)));
			c := unsigned(i_S(((128*8-1)-((offs+2)*64)) downto ((128*8-1)-((offs+3)*64)+1)));
			d := unsigned(i_S(((128*8-1)-((offs+3)*64)) downto ((128*8-1)-((offs+4)*64)+1)));
			
			
			a := resize(a + b + resize(2 * resize((trunc(a) * trunc(b)),63),64),65) mod
			long_bit;
			d := rotate_right(d xor a, 32);
			c := (c + d + 2 * trunc(c) * trunc(d)) mod long_bit;
			b := rotate_right(b xor c, 24);

			a := (a + b + 2 * trunc(a) * trunc(b)) mod long_bit;
			d := rotate_right(d xor a, 32);
			c := (c + d + 2 * trunc(c) * trunc(d)) mod long_bit;
			b := rotate_right(b xor c, 24);


			o_S((128*8-1)-((offs+0)*64) downto ((128*8-1)-((offs+4)*64)+1)) <=
			std_logic_vector(a & b & c & d);
		end loop;

	-- >>> Means in this context a rotation of 64 bit string to the right
	--by n bits
	
	end process;
end beh;


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
	constant long_bit : unsigned(63 downto 0)
	:= "1000000000000000000000000000000000000000000000000000000000000000";	

	type blockR is array (integer range <>) of std_logic_vector(63 downto 0);	
	function trunc (constant a : unsigned(63 downto 0)) return unsigned;

	function f_GB (constant v_in0 : std_logic_vector(63 downto 0);
		constant v_in1 : std_logic_vector(63 downto 0);
		constant v_in2 : std_logic_vector(63 downto 0);
		constant v_in3 : std_logic_vector(63 downto 0))
	return blockR;

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


	--
	-- @brief Calculates GB as per section 3.6
	-- 
	function f_GB (constant v_in0 : std_logic_vector(63 downto 0);
		constant v_in1 : std_logic_vector(63 downto 0);
		constant v_in2 : std_logic_vector(63 downto 0);
		constant v_in3 : std_logic_vector(63 downto 0))
	return blockR is
		--help variables for the permutation process
		variable a : unsigned(64-1 downto 0);
		variable b : unsigned(64-1 downto 0);
		variable c : unsigned(64-1 downto 0);
		variable d : unsigned(64-1 downto 0);
		variable t : unsigned(64-1 downto 0);
		variable v_out : blockR(0 to 3);
	begin
		a  := unsigned(v_in0);
		b  := unsigned(v_in1);
		c  := unsigned(v_in2);
		d  := unsigned(v_in3);

		a := (a + b + 2 * (trunc(a) * trunc(b))) mod long_bit;
		d := rotate_right((d xor a), 32);
		c := (c + d + 2 * (trunc(c) * trunc(d))) mod long_bit;
		b := rotate_right((b xor c), 24);

		a := (a + b + 2 * (trunc(a) * trunc(b))) mod long_bit;
		d := rotate_right((d xor a), 16);
		c := (c + d + 2 * (trunc(c) * trunc(d))) mod long_bit;
		b := rotate_right((b xor c), 63);

		v_out(0) := std_logic_vector(a);
		v_out(1) := std_logic_vector(b);
		v_out(2) := std_logic_vector(c);
		v_out(3) := std_logic_vector(d);
		
		return v_out;
	end;
end permutate_pkg;


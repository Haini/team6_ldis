--------------------------------------------------------------------------------
--
-- AUTHOR: Constantin Schieber <e1228774@student.tuwien.ac.at> 
-- AUTHOR: Petar Kosic <PETARMAIL> 
--
-- Part of the Implementation for the Argon2 Operation function from
-- https://tools.ietf.org/pdf/draft-irtf-cfrg-argon2-03.pdf
-- Section 3.2 Section 5-8
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
--------------------------------------------------------------------------------
--
entity argon2_operation_2 is

	generic(
	);

	port(
		enable_part1	: in std_logic;
		hash_done	: in std_logic; -- Ready bit when hash/tag computation done from Hash Function
		compute_tag : out std_logic_vector( 128*8 -1 downto 0);
		hash        : out std_logic_vector(1024*8 -1 downto 0);
		memory	: inout std_logic_vector(128*8-1 downto 0)
	);

end argon2_operation_2;
--
--------------------------------------------------------------------------------
--
architecture beh of argon2_operation_2 is

	type type_state is (
		STATE_IDLE,
		STATE_COMPUTE_R,
		STATE_COMPUTE_Q,
		STATE_COMPUTE_C,
		STATE_COMPUTE_TAG
	);

	signal state, state_next	: type_state;
	signal tag, C	: std_logic_vector(1023 downto 0); --TODO Fix type
	signal tag_next, C_next	: std_logic_vector(1023 downto 0); --TODO Fix type
	signal tag, tag_next std_logic_vector(1024*8 -1 downto 0)
	
	-- TODO more signals

begin
-- === ARGON 2 Operation Part2 ===
-- === TODO ===

	-- next state & output logic--
	state_out : process(tag, C, hash_done)
	begin

		-- prevent latches, set default values
		state_next	<= state;

		case state is
			when STATE_IDLE =>
				-- TODO
				
				state_next <= STATE_COMPUTE_R;

			when STATE_COMPUTE_R =>
				-- TODO

--5)
--Compute B[i][j] for all i ranging from (and including) 0 to (not
--including) p, and for all j ranging from (and including) 2) to
--(not including) q.  The block indices i’ and j’ are determined
--for each i, j differently for Argon2d, Argon2i, and Argon2id
--(Section 3.4).
			--B[i][j] = G(B[i][j-1], B[i’][j’])
				--Further block generation


				state_next <= STATE_COMPUTE_Q;

			when STATE_COMPUTE_Q =>
				-- TODO

--6)
--If the number of iterations t is larger than 1, we repeat the
--steps however replacing the computations with the following
--expression:
			--B[i][0] = G(B[i][q-1], B[i’][j’])
			--B[i][j] = G(B[i][j-1], B[i’][j’])
					--Further passes
	
	
				state_next <= STATE_COMPUTE_C;

			when STATE_COMPUTE_C =>
				-- TODO
--7)
--After t steps have been iterated, the final block C is computed
--as the XOR of the last column:
			--C = B[0][q-1] XOR B[1][q-1] XOR ... XOR B[p-1][q-1]
						--Final block
						
				C_next <= 0; --dummy
									
				state_next <= STATE_COMPUTE_TAG;
				
			when STATE_COMPUTE_TAG =>
				-- TODO
--8)
--The output tag is computed as H’(C).
-- Call H' Function of Team 5
				compute_tag <= C;
				
				if(hash_done = '1') then
					tag_next <= hash;
					state_next <= STATE_IDLE;	
				end if;			
				
		end case;

	end process state_out;


	-- sync Logic--
	sync : process(clk, rst)
	begin

		if rst = '1' then
			state <= STATE_IDLE;

		elsif rising_edge(clk) then
			state <= state_next;
			tag <= tag_next;
		end if;

	end process sync;

end beh;


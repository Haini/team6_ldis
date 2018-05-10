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

type type_state is (
		STATE_IDLE,
		STATE_COMPUTE_R,
		STATE_COMPUTE_Q,
		STATE_COMPUTE_Z,
		STATE_COMPUTE_OUTPUT
	);

	signal state, state_next	: type_state;
	signal X, Y, P, R, Q, Z		: std_logic_vector(1023 downto 0);
	signal X_next, Y_next, P_next, R_next, Q_next, Z_next	: std_logic_vector(1023 downto 0);

	-- internal to aggregate the received bits to a data word
	-- TODO more signals

begin

	-- next state & output logic--
	state_out : process(X, Y, P, R, Q, Z)
	begin

		-- prevent latches, set default values
		state_next	<= state;
		X_next <= X;
		Y_next <= Y;
		P_next <= P;
		R_next <= R;
		Q_next <= Q;
		Z_next <= Z;

		case state is
			when STATE_IDLE =>
				-- TODO
				X_next <= i_X;
				Y_next <= i_Y;
				
				state_next <= STATE_COMPUTE_R;

			when STATE_COMPUTE_R =>
				-- TODO
				R_next <= X XOR Y;
				
				state_next <= STATE_COMPUTE_Q;

			when STATE_COMPUTE_Q =>
				-- TODO
				
				permuatationfunc <= R
					
				state_next <= STATE_COMPUTE_Z;

			when STATE_COMPUTE_Z =>
				-- TODO
				permuatationfunc <= Z
				
				state_next <= STATE_COMPUTE_OUTPUT;
				
			when STATE_COMPUTE_OUTPUT =>
				-- TODO
				
				output <= Z XOR R;
				state_next <= STATE_IDLE;				
				
		end case;

	end process state_out;

	-- sync Logic--
	sync : process(clk, rst)
	begin

		if rst = '1' then
			state <= STATE_IDLE;

		elsif rising_edge(clk) then
			state <= state_next;
			X <= X_next;
			Y <= Y_next;
			P <= P_next;
			R <= R_next;
			Q <= Q_next;
			Z <= Z_next;
		end if;

	end process sync;

	--data <= data_out;




end beh;


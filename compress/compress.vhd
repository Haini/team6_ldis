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

use work.permutate_pkg.all;
--
--------------------------------------------------------------------------------
--
entity compress is
	
	port(
		i_X : in std_logic_vector(1024*8-1 downto 0);
		i_Y : in std_logic_vector(1024*8-1 downto 0);
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

	constant V_SIZE : integer := 1024*8-1;
	constant VS_SIZE : integer := 128*8-1;

	signal state, state_next	: type_state;
	signal X, Y, P, R, Q, Z		: std_logic_vector(V_SIZE downto 0);
	signal X_next, Y_next, P_next, R_next, Q_next, Z_next	: std_logic_vector(V_SIZE downto 0);

	--Operate on smaller X,Y sizes, do more sequential stuff instead
	signal small_X 	: std_logic_vector(VS_SIZE downto 0);
	signal small_Y 	: std_logic_vector(VS_SIZE downto 0);
	signal i_S 		: std_logic_vector(VS_SIZE downto 0);
	signal o_S 		: std_logic_vector(VS_SIZE downto 0);

	-- internal to aggregate the received bits to a data word
	-- TODO more signals

begin

	en_permutate : entity work.permutate
		
		port map(
			i_S => i_S,	
			o_S	=> o_S
		); 

	compress : process(i_X, i_Y, o_S)
		variable R : std_logic_vector(V_SIZE downto 0);
		variable X : std_logic_vector(V_SIZE downto 0) := i_X; 
		variable Y : std_logic_vector(V_SIZE downto 0) := i_Y; 
		variable s_X : std_logic_vector(VS_SIZE downto 0);
		variable s_Y : std_logic_vector(VS_SIZE downto 0);
		variable COL : std_logic_vector(VS_SIZE downto 0);
	begin

		-- 1.) Do X XOR Y
		R := s_X xor s_Y;

		-- 2.) Permutate Resulting R0...R7
		-- 2.1) Permutate Rows
		for i in 0 to 8 loop
			i_S <= R(V_SIZE - 128*8*i downto V_SIZE - 128*8*(i+1)+1);
			R(V_SIZE - 128*8*i downto V_SIZE - 128*8*(i+1)+1) := o_S;
		end loop;

		-- 2.2) Permutate Columns
		for i in 0 to 8 loop
			for j in 0 to 8 loop
				
			end loop;
		end loop;
		i_S <= R;
		R := o_S; 

	end process;

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


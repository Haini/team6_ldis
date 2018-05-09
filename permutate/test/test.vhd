----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2018 10:12:02
-- Design Name: 
-- Module Name: test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
library std;
use IEEE.STD_LOGIC_1164.ALL;
use std.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
end test;

architecture Behavioral of test is
 function Image(In_Image : Std_Logic_Vector) return String is
       variable L : Line;  -- access type
       variable W : String(1 to In_Image'length) := (others => ' ');
   begin
        WRITE(L, In_Image);
        W(L.all'range) := L.all;
        Deallocate(L);
        return W;
   end Image;


begin

    p_read : process
    file file_in                : text open read_mode is "file_in.txt";
    variable row                : line;
    variable var                : integer := 0;
    variable slv                : std_logic_vector(128*8-1 downto 0);

    begin
          --if(not endfile(file_in)) then
          --    readline(file_in,row);
          --end if;
          --read(row,var);
          read(file_in, var);
          --slv := std_logic_vector(to_unsigned(var,128*8));
          --report "Data=" & integer'image(var);
          report "Data_bin=" & Image(slv);
          report "Sim finish" severity failure;
          
          
    end process p_read;


end Behavioral;

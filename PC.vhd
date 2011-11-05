library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity PC is
	port (
		INPUT:	in STD_LOGIC_VECTOR (31 downto 0);
		THE_PC:	out STD_LOGIC_VECTOR (31 downto 0);
		CLK_H:	in STD_LOGIC;
		RESET:	in STD_LOGIC
);
end PC;

use WORK.all;

architecture BEHAVIORAL of PC is

signal TEMP_PC: STD_LOGIC_VECTOR (31 downto 0);

begin

process (CLK_H, RESET)
begin
	if RESET = '1' then
		TEMP_PC <= X"00000000";
	else 
   	if RISING_EDGE(CLK_H) then
			TEMP_PC <= INPUT;
		end if;
	end if;
end process;

THE_PC <= TEMP_PC;

end BEHAVIORAL;

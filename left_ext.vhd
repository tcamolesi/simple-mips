library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LEFT_EXT is
port (
	SIGN_EXT_H: in STD_LOGIC;
	REG_16_IN: in STD_LOGIC_VECTOR(15 downto 0);	
	REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end LEFT_EXT;

architecture BEHAVIORAL of LEFT_EXT is
--------------------------------------------
-- Component declarations.
--------------------------------------------

--------------------------------------------
-- Signal declarations.
--------------------------------------------

--------------------------------------------
-- Module implementation.
--------------------------------------------
begin

	REG_32_OUT <= (X"FFFF" & REG_16_IN) when (SIGN_EXT_H = '1' and REG_16_IN(15) = '1') 
						else X"0000" & REG_16_IN;

end BEHAVIORAL;

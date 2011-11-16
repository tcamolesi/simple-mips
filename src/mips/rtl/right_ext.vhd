library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RIGHT_EXT is
port (
	REG_16_IN: in STD_LOGIC_VECTOR(15 downto 0);	
	REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end RIGHT_EXT;

architecture BEHAVIORAL of RIGHT_EXT is
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

REG_32_OUT <= REG_16_IN & X"0000";

end BEHAVIORAL;

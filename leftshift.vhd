library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity LEFT_SHIFT is
port (
	REG_26_IN: in STD_LOGIC_VECTOR(25 downto 0);	
	REG_B_IN: in STD_LOGIC_VECTOR(3 downto 0);
	REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end LEFT_SHIFT;

architecture BEHAVIORAL of LEFT_SHIFT is
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

	REG_32_OUT <= REG_B_IN & REG_26_IN & "00";

end BEHAVIORAL;
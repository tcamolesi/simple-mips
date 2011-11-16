library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REG_DATA_MX is
port (
	CSEL_H: in STD_LOGIC;
	REG_A_IN: in STD_LOGIC_VECTOR(31 downto 0);	
	REG_B_IN: in STD_LOGIC_VECTOR(31 downto 0);	

	REG_SEL: out STD_LOGIC_VECTOR(31 downto 0)
	);
end REG_DATA_MX;

architecture BEHAVIORAL of REG_DATA_MX is
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

	REG_SEL <= REG_A_IN when CSEL_H = '0'
			else REG_B_IN;

end BEHAVIORAL;

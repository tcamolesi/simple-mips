library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SET_CONT_MX is
port (
	CSEL_H: in STD_LOGIC_VECTOR(1 downto 0);

	SIG_A: in STD_LOGIC;
	SIG_B: in STD_LOGIC;
	SIG_C: in STD_LOGIC;
	SIG_D: in STD_LOGIC;

	SIG_SEL: out STD_LOGIC_VECTOR(31 downto 0)

);
end SET_CONT_MX;

architecture BEHAVIORAL of SET_CONT_MX is
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
	
   SIG_SEL(31 downto 1) <= "0000000000000000000000000000000";
	SIG_SEL(0) <= SIG_A when CSEL_H = "00" else
				     SIG_B when CSEL_H = "01" else
				     SIG_C when CSEL_H = "10" else
				     SIG_D when CSEL_H = "11" else '0';

end BEHAVIORAL;


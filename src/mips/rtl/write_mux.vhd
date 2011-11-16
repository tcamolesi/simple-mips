library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WRITE_CONT_MX is
port (
	CSEL_H: in STD_LOGIC_VECTOR(2 downto 0);

	SIG_A: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_B: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_C: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_D: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_E: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_F: in STD_LOGIC_VECTOR(31 downto 0);

	SIG_SEL: out STD_LOGIC_VECTOR(31 downto 0)

);
end WRITE_CONT_MX;

architecture BEHAVIORAL of WRITE_CONT_MX is
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

	SIG_SEL <= SIG_A when CSEL_H = "000" else
				  SIG_B when CSEL_H = "001" else
				  SIG_C when CSEL_H = "010" else
				  SIG_D when CSEL_H = "011" else
				  SIG_E when CSEL_H = "100" else
				  SIG_F when CSEL_H = "101" else 
				  "00000000000000000000000000000000";

end BEHAVIORAL;


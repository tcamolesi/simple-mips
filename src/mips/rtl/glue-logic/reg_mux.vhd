library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REG_CONT_MX is
port (
  CSEL_H: in STD_LOGIC_VECTOR (1 downto 0);
  REG_A_IN: in STD_LOGIC_VECTOR(4 downto 0);
  REG_B_IN: in STD_LOGIC_VECTOR(4 downto 0);

  REG_SEL: out STD_LOGIC_VECTOR(4 downto 0)
  );
end REG_CONT_MX;

architecture BEHAVIORAL of REG_CONT_MX is
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

  REG_SEL <= REG_A_IN when CSEL_H = "00" else
          REG_B_IN when CSEL_H = "01"   else "11111";

end BEHAVIORAL;

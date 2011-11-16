library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_CONT_MX is
port (
  CSEL_H: in STD_LOGIC_VECTOR(1 downto 0);
  REG_A_IN: in STD_LOGIC_VECTOR(31 downto 0);
  REG_B_IN: in STD_LOGIC_VECTOR(31 downto 0);
  REG_C_IN: in STD_LOGIC_VECTOR(31 downto 0);
  REG_D_IN: in STD_LOGIC_VECTOR(31 downto 0);

  REG_SEL: out STD_LOGIC_VECTOR(31 downto 0)
  );
end PC_CONT_MX;

architecture BEHAVIORAL of PC_CONT_MX is
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
           REG_B_IN when CSEL_H = "01" else
          REG_C_IN when CSEL_H = "10" else
          REG_D_IN;

end BEHAVIORAL;

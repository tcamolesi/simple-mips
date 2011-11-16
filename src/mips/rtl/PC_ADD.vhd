-- Soma 4 no Programm Counter

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity PC_ADD is
  port (
    PC:   in STD_LOGIC_VECTOR (31 downto 0);
    RESULT: out  STD_LOGIC_VECTOR (31 downto 0)
);

end PC_ADD;

architecture BEHAVIORAL of PC_ADD is
signal NPC : STD_LOGIC_VECTOR (31 downto 0);
begin

NPC <= PC + 4;
RESULT <= NPC;

end BEHAVIORAL;


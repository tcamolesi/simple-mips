library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FS1 is
  port (
    A: in STD_LOGIC;
    B: in STD_LOGIC;
    BIN: in STD_LOGIC;
    FOUT: out STD_LOGIC;
    BOUT: out STD_LOGIC
    );
end FS1;

architecture CAL of FS1 is
begin

  FOUT <= (A xor B) xor BIN;
  BOUT <= (not A and B) or (not A and BIN) or (B and BIN);

end CAL;

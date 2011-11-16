--Somador 1 bit

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FA1 is
  port (
    A: in STD_LOGIC;
    B: in STD_LOGIC;
    CIN: in STD_LOGIC;
    FOUT: out STD_LOGIC;
    COUT: out STD_LOGIC
    );
end FA1;

architecture CAL of FA1 is
begin

  FOUT <= (A xor B) xor CIN;
  COUT <= (A and B) or (A and CIN) or (B and CIN);

end CAL;

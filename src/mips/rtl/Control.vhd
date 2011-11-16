library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTROL is
    port ( OP : in STD_LOGIC_VECTOR(5 downto 0);
           FUNCT : in STD_LOGIC_VECTOR (5 downto 0);
        INST : in STD_LOGIC;
        ZERO : in STD_LOGIC;
         NZERO : in STD_LOGIC;
        NEGAT : in STD_LOGIC;
        GT :  in STD_LOGIC;
        LESS : in STD_LOGIC;
           SIGEXT : out STD_LOGIC;
           SETCONT : out STD_LOGIC_VECTOR(1 downto 0);
           REGDST : out STD_LOGIC_VECTOR (1 downto 0);
           WRITEBACK : out STD_LOGIC_VECTOR(2 downto 0);
           ALUOP : out STD_LOGIC_VECTOR(2 downto 0);
           MEMWRITE : out STD_LOGIC;
           ALUSRC : out STD_LOGIC;
           REGWRITE : out STD_LOGIC;
        PCSRC : out STD_LOGIC_VECTOR(1 downto 0)
        );
end CONTROL;

architecture BEHAVIORAL of CONTROL is

begin

SIGEXT <= '0' when OP = "001001" or OP = "001011" or
             OP = "010101" else '1';

PCSRC <= "01" when OP = "000010" or OP = "000011" else
         "10" when (FUNCT = "001000" or FUNCT = "001001") and
                   (OP = "000000") else
          "11" when (OP = "000101" and ZERO = '0') or
                   (OP = "000100" and ZERO = '1') or
            (OP = "000001" and INST = '0' and NEGAT = '1') or
            (OP = "000001" and INST = '1' and NEGAT = '0') or
            (OP = "010110" and LESS = '0') or
            (OP = "010111" and LESS = '1') else "00";

SETCONT <= "01" when FUNCT = "101010" or FUNCT = "101011" or
                OP = "001010" or OP = "001011" else
        "10" when FUNCT = "011001" else
        "11" when FUNCT = "010111" else "00";



REGDST <= "01" when OP = "000000" else
         "10" when OP = "000011" else "00";




WRITEBACK <= "001" when OP = "100011" else
             "010" when (OP = "000000" and (FUNCT = "101010" or FUNCT = "101011" or
                       FUNCT = "011000" or FUNCT = "011001" or FUNCT = "010111")) or
                        OP = "000101" or OP = "001010" or OP = "001011" else
            "011" when (OP = "000000" and FUNCT = "001001") or OP = "000011" else
            "100" when OP = "001111" else
            "101" when OP = "010101" else "000";

MEMWRITE <= '1' when OP = "101011" else '0';

ALUSRC <= '0' when OP(5 downto 1) = "00000" or OP(5 downto 1) = "00010"
                or OP(5 downto 1) = "01011" else '1';


REGWRITE <= '0' when OP = "101011" or OP = "000100" or
                     OP = "000101" or OP = "000001" or
              OP = "010110" or OP = "010111" or
              OP = "000010" else '1';

ALUOP <= "000" when OP = "000000" else
         "001" when OP(5) = '0' and not(OP = "000100") and
                 not (OP = "000101") and not (OP = "001010") and
              not (OP = "001011") and not (OP = "000001") and
              not (OP = "010110") and not (OP = "010111") else
         "010" when OP(5) = '1' else
      "011" when OP = "000100" or OP = "000101" or
                 OP = "000001" or OP = "010110" or
              OP = "010111" else
      "100" when OP = "001010" or OP = "001011" else "000";

end BEHAVIORAL;

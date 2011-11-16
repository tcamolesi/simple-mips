library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ALU is
  port (
    DATA1:    in STD_LOGIC_VECTOR (31 downto 0);
   DATA2:     in STD_LOGIC_VECTOR (31 downto 0);
   FUNC:    in STD_LOGIC_VECTOR (3 downto 0);
   SHIFTVAL:  in STD_LOGIC_VECTOR (4 downto 0);
   ZERO:    out STD_LOGIC;
   NZERO: out STD_LOGIC;
   LESS:    out STD_LOGIC;
   NEGAT:     out STD_LOGIC;
   GT:      out STD_LOGIC;
   RESULT:  out STD_LOGIC_VECTOR (31 downto 0);
   OVERFLOW:  out STD_LOGIC
   );
end ALU;

use WORK.all;

architecture BEHAVIORAL of ALU is

component FA32 is
  port (
    REG1: in STD_LOGIC_VECTOR (31 downto 0);
    REG2: in STD_LOGIC_VECTOR (31 downto 0);
    CIN: in STD_LOGIC;
    SUM: out STD_LOGIC_VECTOR (31 downto 0);
    COUT: out STD_LOGIC
    );
end component;

component FS32 is
  port (
    REG1: in STD_LOGIC_VECTOR (31 downto 0);
    REG2: in STD_LOGIC_VECTOR (31 downto 0);
    BIN: in STD_LOGIC;
    QUOTIENT: out STD_LOGIC_VECTOR (31 downto 0);
    BOUT: out STD_LOGIC
    );
end component;

signal OUTPUT:  STD_LOGIC_VECTOR (31 downto 0);
signal ADD:     STD_LOGIC_VECTOR (31 downto 0);
signal SUB: STD_LOGIC_VECTOR (31 downto 0);
signal NOTHING: STD_LOGIC;

begin

NOTHING <= '0';

ADDER: FA32
  port map (
    REG1 => DATA1,
    REG2 => DATA2,
    CIN => NOTHING,
    SUM => ADD,
    COUT => open
     );

SUBTRACT: FS32
  port map (
    REG1 => DATA1,
    REG2 => DATA2,
    BIN => NOTHING,
    QUOTIENT => SUB,
    BOUT => open
    );

-- ALU Function Table
-- 0000 ADD
-- 0001 SUBTRACT
-- 0010 AND
-- 0011 OR
-- 0100 SHIFT LEFT LOGICAL
-- 0101 SHIFT RIGHT LOGICAL
-- 0110 XOR
-- 0111 NOR
-- 1000 SHIFT RIGHT ARITHMETIC
-- 1001 NEGATE
-- 1010 NOT
-- 1011 ADDU
-- 1100 SUBU

OUTPUT <= ADD when FUNC = "0000" else
        SUB when FUNC = "0001" else
        DATA1 and DATA2 when FUNC = "0010" else -- and
        DATA1 or DATA2 when FUNC = "0011" else -- or
        DATA2 (30 downto 0) & '0' when FUNC = "0100" else -- Sft L Logical
        '0' & DATA2 (31 downto 1) when FUNC = "0101" else -- Sft R Logical
        DATA1 xor DATA2 when FUNC = "0110" else -- xor
        DATA1 nor DATA2 when FUNC = "0111" else -- nor
        DATA1(31) & DATA1 (31 downto 1) when FUNC = "1000" else -- Sft R Arithmetic
        (not DATA1) + 1 when FUNC = "1001" else -- negate
        not DATA1 when FUNC = "1010" else -- complement
         DATA1 + DATA2 when FUNC = "1011" else  -- add unsigned
        DATA1 - DATA2 when FUNC = "1100" else  -- sub unsigned
          X"00000000";

RESULT <= OUTPUT;

ZERO <= '1' when OUTPUT = X"00000000" else '0';
NZERO <= '0' when OUTPUT = X"00000000" else '1';

NEGAT <= '1' when OUTPUT(31) = '1' else '0';

LESS <= '1' when OUTPUT(31) = '1' else '0';

GT <= '1' when OUTPUT(31) = '0' else '0';

OVERFLOW <= '1' when ((FUNC = "0000" or FUNC = "0001") and
  (DATA1(31) = '1' and DATA2(31) = '1' and OUTPUT(31) = '0')) or
  ((FUNC = "0000" or FUNC = "0001") and
  (DATA1(31) = '0' and DATA2(31) = '0' and OUTPUT(31) = '1')) else '0';

end BEHAVIORAL;


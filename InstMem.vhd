library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

use STD.TEXTIO.all;
use IEEE.STD_LOGIC_TEXTIO.all;

entity INSTRUCTIONS is
  port(
    DATA: out STD_LOGIC_VECTOR(31 downto 0);
    ADDRESS: in STD_LOGIC_VECTOR(31 downto 0);
    CLK: in STD_LOGIC
    );
end INSTRUCTIONS;


architecture BEHAVIORAL of INSTRUCTIONS is
begin

ROM_PROCESS: process(CLK, ADDRESS) is
                                    type MEMORY is array(0 to 511) of STD_LOGIC_VECTOR(7 downto 0);
                                    variable MEM: MEMORY := (others => X"00");
                                    variable IADR: INTEGER;
                                    variable DTEMP: STD_LOGIC_VECTOR(31 downto 0);
                                    variable INIT: INTEGER := 0;
                                    file IN_FILE: TEXT open READ_MODE is "program.txt";
                                    variable BUF: LINE;
                                    variable TADR: INTEGER;
                                    variable TDTA: STD_LOGIC_VECTOR(31 downto 0);
begin

    if INIT = 0 then
      while not(ENDFILE (IN_FILE)) loop
        READLINE(IN_FILE, BUF);
        READ(BUF, TADR);
        READ(BUF, TDTA);
        MEM(TADR) := TDTA(31 downto 24);
			 MEM(TADR + 1) := TDTA(23 downto 16);			 
			 MEM(TADR + 2) := TDTA(15 downto 8);
			 MEM(TADR + 3) := TDTA(7 downto 0);		
      end loop;
      INIT:= 1;
    end if;

    if FALLING_EDGE(CLK) then
      IADR:= CONV_INTEGER(ADDRESS(8 downto 0));
      DTEMP(31 downto 24):= MEM(IADR);
      DTEMP(23 downto 16):= MEM(IADR+1);
      DTEMP(15 downto 8):= MEM(IADR+2);
      DTEMP(7 downto 0):= MEM(IADR+3);
      DATA <= DTEMP;
    end if;
  end process;
end BEHAVIORAL;



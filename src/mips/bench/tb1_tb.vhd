library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;



entity TB1 is
end TB1;

use WORK.all;

architecture TB1 of TB1 is

component PROCESSOR is
port(
      INPUT  : in STD_LOGIC_VECTOR (31 downto 0);
    CLK_H  : in STD_LOGIC;
    RST_H  : in STD_LOGIC;
    IR: in STD_LOGIC_VECTOR (31 downto 0);
     DATAADD: out STD_LOGIC_VECTOR (31 downto 0);
    INSTADD: out STD_LOGIC_VECTOR (31 downto 0);
    OVERFLOW: out STD_LOGIC;
    MEMWR : out STD_LOGIC;
      OUTPUT : out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component DATAMEMORY is
  port (
        INPUT     : in STD_LOGIC_VECTOR (31 downto 0);
         ADDRESS   : in STD_LOGIC_VECTOR (31 downto 0);
         MEM_WRITE : in STD_LOGIC;
         CLK       : in STD_LOGIC;
      OUTPUT    : out STD_LOGIC_VECTOR (31 downto 0)
         );
end component;

component INSTRUCTIONS is
  port(
    DATA: out STD_LOGIC_VECTOR(31 downto 0);
    ADDRESS: in STD_LOGIC_VECTOR(31 downto 0);
    CLK: in STD_LOGIC
    );
end component;


--signals
signal TB_CLK_H : STD_LOGIC;
signal TB_RST_H : STD_LOGIC;
signal TB_PROCIN : STD_LOGIC_VECTOR (31 downto 0);
signal TB_MEMWE : STD_LOGIC;
signal TB_DADD : STD_LOGIC_VECTOR (31 downto 0);
signal TB_IADD : STD_LOGIC_VECTOR (31 downto 0);
signal TB_PROCOUT : STD_LOGIC_VECTOR (31 downto 0);
signal TB_IR : STD_LOGIC_VECTOR (31 downto 0);
signal TB_OVERFLOW : STD_LOGIC;
signal CYCLE: INTEGER := 1;

begin

--clock process
CLK_PROC : process
begin
  TB_CLK_H <= '1';
  wait for 200 ns;
  TB_CLK_H <= '0';
  wait for 200 ns;
  CYCLE <= CYCLE + 1;
end process;

TB_RST_H <= '1' when CYCLE < 5 else '0';


P1 : PROCESSOR
port map(
     INPUT => TB_PROCIN,
    CLK_H  => TB_CLK_H,
    RST_H  => TB_RST_H,
    IR  => TB_IR,
     DATAADD => TB_DADD,
    INSTADD => TB_IADD,
    OVERFLOW => TB_OVERFLOW,
    MEMWR => TB_MEMWE,
      OUTPUT => TB_PROCOUT
);


D1 : DATAMEMORY
port map(
       INPUT  => TB_PROCOUT,
       ADDRESS  => TB_DADD,
       MEM_WRITE => TB_MEMWE,
       CLK    => TB_CLK_H,
      OUTPUT  => TB_PROCIN
);


I1 : INSTRUCTIONS
port map (
   DATA => TB_IR,
    ADDRESS => TB_IADD,
    CLK => TB_CLK_H
);

end TB1;



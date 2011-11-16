library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DATAMEMORY is

  generic ( RDEL, DISDEL : TIME := 10 ns );

  port (
        INPUT     : in STD_LOGIC_VECTOR (31 downto 0);
       ADDRESS   : in STD_LOGIC_VECTOR (31 downto 0);
       MEM_WRITE : in STD_LOGIC;
       CLK       : in STD_LOGIC;
      OUTPUT    : out STD_LOGIC_VECTOR (31 downto 0)
         );

end DATAMEMORY;

architecture BEHAVIORAL of DATAMEMORY is

  type   MEMORY is array (0 to 511) of STD_LOGIC_VECTOR (7 downto 0);
  signal MEM : MEMORY;
  signal OUTS: STD_LOGIC_VECTOR(31 downto 0);

begin

  process ( MEM_WRITE, CLK, ADDRESS, INPUT ) is
  begin
    if FALLING_EDGE(CLK) then
      if MEM_WRITE = '1' then
        MEM(CONV_INTEGER(ADDRESS(8 downto 0))) <= INPUT(31 downto 24);
        MEM(CONV_INTEGER(ADDRESS(8 downto 2) & "01")) <= INPUT(23 downto 16);
        MEM(CONV_INTEGER(ADDRESS(8 downto 2) & "10")) <= INPUT(15 downto 8);
       MEM(CONV_INTEGER(ADDRESS(8 downto 2) & "11")) <= INPUT(7 downto 0);
      end if;
    end if;
end process;


OUTS(31 downto 24) <= MEM(CONV_INTEGER(ADDRESS(8 downto 0)));
OUTS(23 downto 16) <= MEM(CONV_INTEGER(ADDRESS(8 downto 2) & "01"));
OUTS(15 downto 8) <= MEM(CONV_INTEGER(ADDRESS(8 downto 2) & "10"));
OUTS(7 downto 0) <= MEM(CONV_INTEGER(ADDRESS(8 downto 2) & "11"));

OUTPUT <= OUTS;

end BEHAVIORAL;


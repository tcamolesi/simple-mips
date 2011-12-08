library ieee;
use ieee.std_logic_1164.all;

use work.toplevel;

entity tb_addi is
end tb_addi;

architecture test of tb_addi is
  component toplevel is
    generic (
      init_file         : string
    );
    port (
      rst_i             : in  std_logic;
      ck_i              : in  std_logic
    );
  end component;

 signal ck          : std_logic;
 signal rst         : std_logic;
begin
  system: toplevel
    generic map (
      init_file => "../../../src/mips/bench/tb_addi.hex"
    )
    port map (
      rst_i     => rst,
      ck_i      => ck
    );

  rst_proc: process
  begin
    rst <= '1';
    wait for 50 ns;
    rst <= '0';
    wait;
  end process;

  ck_proc: process
  begin
    wait for 10 ns;
    ck <= '0';
    wait for 10 ns;
    ck <= '1';
  end process;

end architecture;

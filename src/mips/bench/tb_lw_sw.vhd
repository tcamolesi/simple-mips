-- Purpose: Test LW and SW Instructions
-- Program file: tb_lw_sw.hex
-- Disassembled code:
--   addi  $1, $0, 15; $1  = 15
--   addi  $2, $0, 25; $2  = 25
--     sw  $1, 0($0) ; *($0 +  0) = $1
--     sw  $2, 0($1) ; *($1 +  0) = $2
--     sw  $2, 25($0); *($0 + 25) = $2
--     lw  $3, 0($0) ; $3 = *($0 + 0)
--     lw  $4, 0($1) ; $4 = *($1 + 0)
--     lw  $5, 0($2) ; $5 = *($2 + 0)
-- Relevant signals:
--   system/processor/reg_bank/gen_regs(1)/regs/q_o
--   system/processor/reg_bank/gen_regs(2)/regs/q_o
--   system/processor/reg_bank/gen_regs(3)/regs/q_o
--   system/processor/reg_bank/gen_regs(4)/regs/q_o
--   system/processor/reg_bank/gen_regs(5)/regs/q_o

library ieee;
use ieee.std_logic_1164.all;

use work.toplevel;

entity tb_lw_sw is
end tb_lw_sw;

architecture test of tb_lw_sw is
  component toplevel is
    generic (
      init_file         : string
    );
    port (
      rst_i             : in  std_logic;
      ck_i              : in  std_logic;
      mem_ck_i          : in  std_logic
    );
  end component;

 signal ck          : std_logic;
 signal mem_ck      : std_logic;
 signal rst         : std_logic;
begin
  system: toplevel
    generic map (
      init_file => "../../../src/mips/bench/tb_lw_sw.hex"
    )
    port map (
      rst_i     => rst,
      ck_i      => ck,
      mem_ck_i  => mem_ck
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
    mem_ck <= '0' after 1 ns;
    wait for 10 ns;
    ck <= '1';
    mem_ck <= '1' after 1 ns;
  end process;

end architecture;

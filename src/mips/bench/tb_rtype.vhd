-- Purpose: Test R-Type Instructions
-- Program file: tb_rtype.hex
-- Disassembled code:
--   addi  $1, $0, 10; $1  = 10
--   addi  $2, $0,  3; $2  =  3
--   add   $3, $1, $2; $3  = $1 + $2
--   and   $4, $1, $2; $4  = $1 & $2
--   or    $5, $1, $2; $5  = $1 | $2
--   sub   $6, $1, $2; $6  = $1 - $2
--   sub   $7, $2, $1; $7  = $2 - $1
--   slt   $8, $1, $2; $8  = $1 < $2 ? 1 : 0
--   slt   $9, $2, $1; $9  = $2 < $1 ? 1 : 0
--   slt  $10, $1, $1; $10 = $1 < $1 ? 1 : 0
-- Relevant signals:
--   system/processor/reg_bank/gen_regs(1)/regs/q_o
--   system/processor/reg_bank/gen_regs(2)/regs/q_o
--   system/processor/reg_bank/gen_regs(3)/regs/q_o
--   system/processor/reg_bank/gen_regs(4)/regs/q_o
--   system/processor/reg_bank/gen_regs(5)/regs/q_o
--   system/processor/reg_bank/gen_regs(6)/regs/q_o
--   system/processor/reg_bank/gen_regs(7)/regs/q_o
--   system/processor/reg_bank/gen_regs(8)/regs/q_o
--   system/processor/reg_bank/gen_regs(9)/regs/q_o
--   system/processor/reg_bank/gen_regs(10)/regs/q_o

library ieee;
use ieee.std_logic_1164.all;

use work.toplevel;

entity tb_rtype is
end tb_rtype;

architecture test of tb_rtype is
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
      init_file => "../../../src/mips/bench/tb_rtype.hex"
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

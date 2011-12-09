-- Purpose: Test branch instructions
-- Program file: tb_branch.hex
-- Disassembled code:
--   main: addi $2, $0, 10;
--         addi $3, $0, 20;
--         addi $4, $0,  5;
--   
--         beq  $2, $2, l0;
--         addi $5, $0, 1;
--   
--   l0:   addi $4, $4, -1;
--         bne  $4, $0, l0;
--   
--   here: beq  $0, $0, here;
-- Relevant signals:
--   system/processor/reg_bank/gen_regs(2)/regs/q_o
--   system/processor/reg_bank/gen_regs(3)/regs/q_o
--   system/processor/reg_bank/gen_regs(4)/regs/q_o
--   system/processor/reg_bank/gen_regs(5)/regs/q_o

library ieee;
use ieee.std_logic_1164.all;

use work.toplevel;

entity tb_branch is
end tb_branch;

architecture test of tb_branch is
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
      init_file => "../../../src/mips/bench/tb_branch.hex"
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

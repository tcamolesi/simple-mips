-- Purpose: Test ADDI Instruction
-- Program file: tb_addi.hex
-- Disassembled code:
--   addi $1, $0, 15; reg1  = 15
--   addi $1, $1,  1; reg1 += 1
--   addi $2, $0,  1; reg2  = 1
--   addi $2, $1,  0; reg2  = reg1
-- Relevant signals:
--   system/processor/reg_bank/gen_regs(1)/regs/q_o
--   system/processor/reg_bank/gen_regs(2)/regs/q_o

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
      init_file => "../../../src/mips/bench/tb_addi.hex"
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

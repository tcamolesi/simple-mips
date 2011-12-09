-- Purpose: Test branch instructions
-- Program file: tb_branch.hex
-- Disassembled code:
--         addi $2, $1,  5;
--   
--         j    ok1
--         addi $2, $0,  0;
--
--   ok2:  addi $3, $0,  1;
--         j    end
--   ok1:  j    ok2
--   end:  addi $4, $0,  1;
--   halt: j    halt
--
-- Relevant signals:
--   system/processor/reg_bank/gen_regs(2)/regs/q_o
--   system/processor/reg_bank/gen_regs(3)/regs/q_o
--   system/processor/reg_bank/gen_regs(4)/regs/q_o

library ieee;
use ieee.std_logic_1164.all;

use work.toplevel;

entity tb_jump is
end tb_jump;

architecture test of tb_jump is
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
      init_file => "../../../src/mips/bench/tb_jump.hex"
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

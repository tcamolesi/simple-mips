library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

package alu_pack is
  subtype alu_op_t is std_logic_vector(3 downto 0);

  constant op_add  : alu_op_t := "0000";
  constant op_sub  : alu_op_t := "0001";
  constant op_and  : alu_op_t := "0010";
  constant op_or   : alu_op_t := "0011";
  constant op_sll  : alu_op_t := "0100";
  constant op_srl  : alu_op_t := "0101";
  constant op_xor  : alu_op_t := "0110";
  constant op_nor  : alu_op_t := "0111";
  constant op_sra  : alu_op_t := "1000";
  constant op_neg  : alu_op_t := "1001";
  constant op_not  : alu_op_t := "1010";
  constant op_addu : alu_op_t := "1011";
  constant op_subu : alu_op_t := "1100";

  component alu is
    port (
      op1_i     : in  dw_t;      -- First operand
      op2_i     : in  dw_t;      -- Second operand
      func_i    : in  alu_op_t;  -- Operation

      res_o     : out dw_t;      -- Result
      zf_o      : out std_logic; -- Zero flag
      bf_o      : out std_logic  -- Borrow flag
    );
  end component;
end package;

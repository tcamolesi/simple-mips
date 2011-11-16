library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.core_pack.all;
use work.alu_pack.all;

entity alu is
  port (
    op1_i     : in  dw_t;      -- First operand
    op2_i     : in  dw_t;      -- Second operand
    func_i    : in  alu_op_t;  -- Operation

    res_o     : out dw_t;      -- Result
    zf_o      : out std_logic; -- Zero flag
    bf_o      : out std_logic  -- Borrow flag
  );
end alu;

architecture behavioral of alu is
  subtype alu_dw_t is signed(dw_t'HIGH + 1 downto 0);
begin
  datapath: process(op1_i, op2_i, func_i)

    variable op1_ext,
             op2_ext,
             res_v,
             add_v,
             sub_v,
             and_v,
             or_v,
             sll_v,
             srl_v,
             xor_v,
             nor_v,
             sra_v,
             neg_v,
             not_v  : alu_dw_t;

  begin
    op1_ext := resize(signed(op1_i), alu_dw_t'length);
    op2_ext := resize(signed(op2_i), alu_dw_t'length);

    add_v := op1_ext +   op2_ext;
    sub_v := op1_ext -   op2_ext;
    and_v := op1_ext and op2_ext;
    or_v  := op1_ext or  op2_ext;
  end process;
end BEHAVIORAL;


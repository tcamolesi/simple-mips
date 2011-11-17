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
             xor_v,
             nor_v,
             neg_v,
             not_v,
             shift_v : alu_dw_t;
    variable shift_w : dw_t;

  begin
    op1_ext := resize(signed(op1_i), alu_dw_t'length);
    op2_ext := resize(signed(op2_i), alu_dw_t'length);

    add_v   := op1_ext +   op2_ext;
    sub_v   := op1_ext -   op2_ext;
    and_v   := op1_ext and op2_ext;
    or_v    := op1_ext or  op2_ext;
    xor_v   := op1_ext xor op2_ext;
    nor_v   := op1_ext nor op2_ext;
    neg_v   := -op1_ext;
    not_v   := not op1_ext;
    shift_w := alu_shift(op1_i,
                         op2_i(4 downto 0),
                         func_i = op_sra,       -- Only SRA is an arithmetic shift
                         not (func_i = op_sll));-- Only SLL is a left shift

    shift_v := resize(signed(shift_w), alu_dw_t'length);

    case func_i is
        when op_add | op_addu => res_v := add_v;
        when op_sub | op_subu => res_v := sub_v;
        when op_and           => res_v := and_v;
        when op_or            => res_v := or_v;
        when op_xor           => res_v := xor_v;
        when op_nor           => res_v := nor_v;
        when op_neg           => res_v := neg_v;
        when op_not           => res_v := not_v;
        when others           => res_v := shift_v;
    end case;

    res_o <= std_logic_vector(res_v(res_o'range));
    bf_O  <= not res_v(res_v'high);

    if res_v = 0 then
      zf_o <= '1';
    else
      zf_o <= '0';
    end if;
  end process;
end BEHAVIORAL;

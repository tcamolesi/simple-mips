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
             and_v,
             or_v,
             sub_v,
             nsub_v,
             slt_v : alu_dw_t;
    variable shift_w : dw_t;

  begin
    op1_ext := resize(signed(op1_i), alu_dw_t'length);
    op2_ext := resize(signed(op2_i), alu_dw_t'length);

    add_v   := op1_ext +   op2_ext;
    and_v   := op1_ext and op2_ext;
     or_v   := op1_ext or  op2_ext;
    sub_v   := op1_ext -   op2_ext;
    nsub_v  := not sub_v;

    -- 1 if op1 - op2 < 0 (checks sign bit). 0 otherwise
    slt_v   := (0 => sub_v(sub_v'high), others => '0');

    case func_i is
        when op_add => res_v := add_v;
        when op_and => res_v := and_v;
        when op_or  => res_v := or_v;
        when op_sub => res_v := sub_v;
        when op_nsub=> res_v := nsub_v;
        when op_slt => res_v := slt_v;
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

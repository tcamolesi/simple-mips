library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

package alu_pack is
  type alu_op_t is (op_add, op_sub, op_and, op_or, op_nsub, op_slt);

  function alu_shift(op1         : in dw_t;
                     op2         : in std_logic_vector(4 downto 0);
                     arith_flag  : in boolean;
                     is_left     : in boolean
                     ) return dw_t;

end package;

package body alu_pack is

  -- Based on Jose A. Ruiz's barrel shifter
  function alu_shift(op1         : in dw_t;
                     op2         : in std_logic_vector(4 downto 0);
                     arith_flag  : in boolean;
                     is_left     : in boolean
                     ) return dw_t is
    variable v  : dw_t;
    variable cf : dw_t;
  begin
    if is_left then
      v := op1;
    else
      for i in op1'high downto op1'low loop
        v(i) := op1(op1'high-i);
      end loop;
    end if;

    if arith_flag then
      cf := (others => op1(op1'high));
    else
      cf := (others => '0');
    end if;

    -- Build left barrel shifter in 5 binary stages as usual
    for i in 0 to 4 loop
      if op2(i) = '1' then
        v := v(31-2**i downto 0) & cf(2**i-1 downto 0);
      end if;
    end loop;

    -- Reverse output when shifting right
    if is_left then
      for i in op1'high downto op1'low loop
        v(i) := op1(op1'high-i);
      end loop;
    end if;

    return v;
  end function;

end package body;

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

  function alu_shift(op1         : in dw_t;
                     op2         : in std_logic_vector(4 downto 0);
                     arith_flag  : in boolean;
                     is_left     : in boolean
                     ) return dw_t;

end package;

package body alu_pack is

  -- Based on Jose A. Ruiz's barrel shifter
  function alu_shift(op1         : in std_logic_vector;
                     op2         : in std_logic_vector(4 downto 0);
                     arith_flag  : in boolean;
                     is_left     : in boolean
                     ) return dw_t is
    variable v  : dw_t;
    variable cf : dw_t;
  begin
    if is_left = '0' then
      v := op1;
    else
      for i in op1'high downto op1'low loop
        v(i) := op1(op1'high-i);
      end loop;
    end if;

    if arith_flag = '1' then
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
    if is_left = '1' then
      for i in op1'high downto op1'low loop
        v(i) := op1(op1'high-i);
      end loop;
    end if;

    return v;
  end function;

end package body;

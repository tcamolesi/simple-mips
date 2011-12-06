library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.core_pack.all;

package control_pack is

  type instruction_t is (r_type, lw_type, sw_type, addi_type, beq_type, bne_type);
  function get_instr_type(op : in opcode_t) return instruction_t;

end package;

package body control_pack is
  function get_instr_type(op : in opcode_t) return instruction_t is
  begin
    if op = "000000" then
      return r_type;
    elsif op = "100011" then
      return lw_type;
    elsif op = "101011" then
      return sw_type;
    elsif op = "000100" then
      return beq_type;
    elsif op = "000101" then
      return bne_type;
    else
      return addi_type;
    end if;
  end function;
end package body;

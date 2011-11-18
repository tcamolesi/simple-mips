library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.core_pack.all;

package control_pack is

  type instruction_t is (r_type, lw_type, sw_type, beq_type);

  subtype opcode_t is std_logic_vector( 5 downto 0);
  subtype reg_id_t is std_logic_vector( 4 downto 0);
  subtype funct_t  is std_logic_vector( 5 downto 0);
  subtype immed_t  is std_logic_vector(15 downto 0);

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
    else
      return beq_type;
    end if;
  end function;
end package body;

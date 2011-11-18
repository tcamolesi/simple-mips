library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;
use work.control_pack.all;
use work.alu_pack.all;

entity alu_control is
  port (
    alucontrol_i    : in instruction_t;
    funct_i         : in funct_t;

    aluop_o         : out alu_op_t
   );
end alu_control;

architecture behavioral of alu_control is
begin
  process(alucontrol_i, funct_i)
  begin
    case alucontrol_i is
      when beq_type => aluop_o <= op_xor;
      when lw_type  => aluop_o <= op_add;
      when sw_type  => aluop_o <= op_add;
      when r_type   => case funct_i is
                         when "100000" => aluop_o <= op_add;
                         when "100010" => aluop_o <= op_sub;
                       end case;
    end case;
  end process;
end;

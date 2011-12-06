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
      when beq_type => aluop_o <= op_sub;  --BEQ => sets zf if (op1 - op2) == 0
      when bne_type => aluop_o <= op_nsub; --BNE => sets zf if (op1 - op2) != 0
      when lw_type  => aluop_o <= op_add; --LW
      when sw_type  => aluop_o <= op_add; --SW
      when addi_type=> aluop_o <= op_add; --ADDI
      when r_type   => case funct_i is
                         when "100000" => aluop_o <= op_add; --ADD
                         when "100001" => aluop_o <= op_add; --ADDU
                         when "100010" => aluop_o <= op_sub; --SUB
                         when "100011" => aluop_o <= op_sub; --SUBU
                         when "100100" => aluop_o <= op_and; --AND
                         when "100101" => aluop_o <= op_or;  --OR
                         when others   => aluop_o <= op_add;
                       end case;
    end case;
  end process;
end;

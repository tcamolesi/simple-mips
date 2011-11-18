library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;
use work.control_pack.all;

entity control_unit is
  port (
    instr_i         : in  dw_t;

    reg_dst_o       : out std_logic;
    branch_o        : out std_logic;
    mem_to_reg_o    : out std_logic;
    alu_op_o        : out std_logic;
    mem_r_o         : out std_logic;
    mem_wr_o        : out std_logic;
    alu_src_o       : out std_logic;
    reg_wr_o        : out std_logic;
    alucontrol_o    : out instruction_t
   );
end control_unit;

architecture behavioral of control_unit is
  alias op     : opcode_t is instr_i(31 downto 25);

  alias rs     : reg_id_t is instr_i(24 downto 19);
  alias rt     : reg_id_t is instr_i(18 downto 13);
  alias rd     : reg_id_t is instr_i(13 downto  8);
  alias funct  : funct_t  is instr_i( 5 downto  0);
  alias immed  : immed_t  is instr_i(15 downto  0);

begin
  process(instr_i)
    variable type_v : instruction_t;
  begin
    type_v := get_instr_type(op);

    case type_v is
      when r_type   => reg_dst_o    <= '1';
                       alu_src_o    <= '0';
                       mem_to_reg_o <= '0';
                       reg_wr_o     <= '1';
                       mem_r_o      <= '0';
                       mem_wr_o     <= '0';
                       branch_o     <= '0';

      when lw_type  => reg_dst_o    <= '0';
                       alu_src_o    <= '1';
                       mem_to_reg_o <= '1';
                       reg_wr_o     <= '1';
                       mem_r_o      <= '1';
                       mem_wr_o     <= '0';
                       branch_o     <= '0';

      when sw_type  => reg_dst_o    <= '0';
                       alu_src_o    <= '1';
                       mem_to_reg_o <= '0';
                       reg_wr_o     <= '0';
                       mem_r_o      <= '0';
                       mem_wr_o     <= '1';
                       branch_o     <= '0';

      when beq_type => reg_dst_o    <= '0';
                       alu_src_o    <= '0';
                       mem_to_reg_o <= '0';
                       reg_wr_o     <= '0';
                       mem_r_o      <= '0';
                       mem_wr_o     <= '0';
                       branch_o     <= '1';
    end case;

    alucontrol_o <= type_v;
  end process;
end behavioral;

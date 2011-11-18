library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;
use work.control_pack.all;
use work.alu_pack.all;

entity control_unit is
  port (
    instr_i         : in dw_t;

    reg_dst_o       : out std_logic;       
    branch_o        : out std_logic;      
    mem_to_reg_o    : out std_logic;          
    alu_op_o        : out std_logic;      
    mem_r_o         : out std_logic;     
    mem_wro         : out std_logic;     
    alu_src_o       : out std_logic;       
    reg_wr_o        : out std_logic;      
    aluop_o         : out alu_op_t
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

end behavioral;

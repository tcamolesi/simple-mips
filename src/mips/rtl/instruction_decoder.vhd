library ieee;
use ieee.std_logic_1164.all;

use work.control_pack.all;
use work.core_pack.all;

entity intruction_decoder is
  port (
    instr_i     : in  dw_t;

    op_o        : out opcode_t;
    rs_o        : out reg_id_t;
    rt_o        : out reg_id_t;
    rd_o        : out reg_id_t;
    funct_o     : out funct_t;
    immed_o     : out immed_t
   );
end intruction_decoder;

architecture behavioral of intruction_decoder is
  alias op     : opcode_t is instr_i(31 downto 25);
  alias rs     : reg_id_t is instr_i(24 downto 19);
  alias rt     : reg_id_t is instr_i(18 downto 13);
  alias rd     : reg_id_t is instr_i(13 downto  8);
  alias funct  : funct_t  is instr_i( 5 downto  0);
  alias immed  : immed_t  is instr_i(15 downto  0);

begin
  op_o    <= op;
  rs_o    <= rs;
  rt_o    <= rt;
  rd_o    <= rd;
  funct_o <= funct;
  immed_o <= immed;
end behavioral;

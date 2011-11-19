library ieee;
use ieee.std_logic_1164.all;

package core_pack is

  subtype dw_t     is std_logic_vector(31 downto 0);
  subtype opcode_t is std_logic_vector( 5 downto 0);
  subtype reg_id_t is std_logic_vector( 4 downto 0);
  subtype funct_t  is std_logic_vector( 5 downto 0);
  subtype immed_t  is std_logic_vector(15 downto 0);

end package;

package body core_pack is
end package body;

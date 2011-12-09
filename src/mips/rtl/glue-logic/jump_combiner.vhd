library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

entity jump_combiner is
  port (
    pc_i            : in  dw_t;
    targ_addr_i     : in  j_targ_t;

    addr_o          : out dw_t
  );
end jump_combiner;

architecture behavioral of jump_combiner is
begin
  addr_o <= pc_i(dw_t'high downto dw_t'high - 3) & targ_addr_i & "00";
end behavioral;

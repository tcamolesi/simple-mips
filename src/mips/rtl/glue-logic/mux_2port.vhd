library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

entity mux_2port is
  generic (
    bus_width_g : natural := dw_t'length
  );
  port (
    d0_i  : in  std_logic_vector(bus_width_g - 1 downto 0);
    d1_i  : in  std_logic_vector(bus_width_g - 1 downto 0);
    sel_i : in  std_logic;

    q_o   : out std_logic_vector(bus_width_g - 1 downto 0)
  );
end mux_2port;

architecture behavioral of mux_2port is
begin
  with sel_i select 
    q_o <= d0_i when '0',
           d1_i when others;
end behavioral;

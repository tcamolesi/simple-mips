library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

entity left_shifter is
  generic (
    shift_amount_g : natural := 2;
    bus_width_g    : natural := dw_t'length
  );
  port (
    d_i : in  std_logic_vector(bus_width_g - 1 downto 0);
    q_o : out std_logic_vector(bus_width_g - 1 downto 0)
  );
end left_shifter;

architecture behavioral of left_shifter is
  constant zeroes : std_logic_vector(shift_amount_g - 1 downto 0) := (others => '0');
begin
  q_o <= d_i(d_i'high - shift_amount_g downto 0) & zeroes;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_g is
  generic (
    bus_width_g   : integer := 32
  );
  port (
    d1_i : in  std_logic_vector(bus_width_g - 1 downto 0);
    d2_i : in  std_logic_vector(bus_width_g - 1 downto 0);

    q_o  : out std_logic_vector(bus_width_g - 1 downto 0)
   );
end adder_g;

architecture behavioral of adder_g is
begin
  q_o <= std_logic_vector(unsigned(d1_i) + unsigned(d2_i));
end behavioral;

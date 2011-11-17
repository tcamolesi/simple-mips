library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender is
  generic (
    inp_width_g   : integer := 16;
    outp_width_g  : integer := 32
  );
  port (
    d_i : in  std_logic_vector(inp_width_g - 1 downto 0);

    q_o : out std_logic_vector(outp_width_g - 1 downto 0)
   );
end sign_extender;

architecture behavioral of sign_extender is
begin
  q_o <= std_logic_vector(resize(signed(d_i), q_o'length));
end behavioral;

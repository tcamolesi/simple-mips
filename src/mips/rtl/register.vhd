library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

entity reg_g is
  generic (
    nbits_g : natural := dw_t'length
  );
  port (
    d_i     : in std_logic_vector(nbits_g - 1 downto 0);
    ck_i    : in std_logic;
    rst_i   : in std_logic;
    wr_en_i : in std_logic;

    q_o     : out std_logic_vector(nbits_g - 1 downto 0)
);
end reg_g;

architecture behavioral of reg_g is
begin
  process (ck_i, rst_i)
  begin
    if rst_i = '1' then
      q_o <= (others => '0');
    else
      if rising_edge(ck_i) then
        q_o <= d_i;
      end if;
    end if;
  end process;
end behavioral;

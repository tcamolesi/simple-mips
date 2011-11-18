library ieee;
use ieee.std_logic_1164.all;

package core_pack is

  subtype dw_t     is std_logic_vector(31 downto 0);
  subtype opcode_t is std_logic_vector( 5 downto 0);
  subtype reg_id_t is std_logic_vector( 4 downto 0);
  subtype funct_t  is std_logic_vector( 5 downto 0);
  subtype immed_t  is std_logic_vector(15 downto 0);

  component reg_g is
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
  end component;

end package;

library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

package glue_pack is

  component mux_2port is
    generic (
      bus_width_g : natural := dw_t'length
    );
    port (
      d0_i  : in  std_logic_vector(bus_width_g - 1 downto 0);
      d1_i  : in  std_logic_vector(bus_width_g - 1 downto 0);
      sel_i : in  std_logic;

      q_o   : out std_logic_vector(bus_width_g - 1 downto 0)
    );
  end component;

  component left_shifter is
    generic (
      shift_amount_g : natural := 2;
      bus_width_g    : natural := dw_t'length
    );
    port (
      d_i : in  std_logic_vector(bus_width_g - 1 downto 0);
      q_o : out std_logic_vector(bus_width_g - 1 downto 0)
    );
  end component;

  component sign_extender is
    generic (
      inp_width_g   : integer := 16;
      outp_width_g  : integer := 32
    );
    port (
      d_i : in  std_logic_vector(inp_width_g - 1 downto 0);

      q_o : out std_logic_vector(outp_width_g - 1 downto 0)
     );
  end component;

  component adder_g is
    generic (
      bus_width_g   : integer := 32
    );
    port (
      d1_i : in  std_logic_vector(bus_width_g - 1 downto 0);
      d2_i : in  std_logic_vector(bus_width_g - 1 downto 0);

      q_o  : out std_logic_vector(bus_width_g - 1 downto 0)
     );
  end component;
end package;

package body glue_pack is
end package body;

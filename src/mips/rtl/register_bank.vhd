library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.core_pack.all;

entity reg_bank_3port is
  generic (
    sel_bits_g : natural := 5
  );
  port (
     r0_sel  : in std_logic_vector(sel_bits_g - 1 downto 0);
     r1_sel  : in std_logic_vector(sel_bits_g - 1 downto 0);
     rw_sel  : in std_logic_vector(sel_bits_g - 1 downto 0);
     d_i     : in dw_t;
     we_i    : in std_logic;
     ck_i    : in std_logic;
     rst_i   : in std_logic;

     q0_o    : out dw_t;
     q1_o    : out dw_t
  );
end reg_bank_3port;

architecture structural of reg_bank_3port is
  subtype addr_t is natural range (2**sel_bits_g - 1) downto 0;
  type qo_s_t is array (addr_t'range) of dw_t;

  signal we_s : std_logic_vector(addr_t);
  signal qo_s : qo_s_t;

begin
  gen_regs: for i in addr_t'range generate
    regs: reg_g generic map(nbits_g => dw_t'length)
                port map(
                  d_i     => d_i,
                  ck_i    => ck_i,
                  rst_i   => rst_i,
                  wr_en_i => we_s(i),
                  q_o     => qo_s(i)
                );

    we_s(i) <= '1' when rw_sel = std_logic_vector(to_unsigned(i, rw_sel'length))
                        and we_i = '1'
                   else '0';
  end generate;

  q0_o <= qo_s(to_integer(unsigned(r0_sel)));
  q1_o <= qo_s(to_integer(unsigned(r1_sel)));
end structural;

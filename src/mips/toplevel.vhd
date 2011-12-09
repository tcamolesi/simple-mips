library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;

use work.mips;
use work.mips_ram;
use work.mips_rom;

entity toplevel is
  generic (
    init_file         : string := "../../../src/mips/romdata.hex"
  );
  port (
    rst_i             : in  std_logic;
    ck_i              : in  std_logic;
    mem_ck_i          : in  std_logic
  );
end toplevel;

architecture structural of toplevel is
  component mips is
    port (
      rst_i             : in  std_logic;
      ck_i              : in  std_logic;
      instr_rdata_i     : in  dw_t;
      data_rdata_i      : in  dw_t;

      data_w_en_o       : out std_logic;
      data_r_en_o       : out std_logic;
      data_wdata_o      : out dw_t;
      data_addr_o       : out dw_t;
      instr_addr_o      : out dw_t
    );
  end component;

  component mips_ram is
    port
    (
      address : in std_logic_vector (7 downto 0);
      clock   : in std_logic  := '1';
      data    : in std_logic_vector (31 downto 0);
      wren    : in std_logic ;
      q       : out std_logic_vector (31 downto 0)
    );
  end component;

  component mips_rom is
    generic
    (
      init_file : string
    );
    port
    (
      address : in std_logic_vector (9 downto 0);
      clock   : in std_logic  := '1';
      q       : out std_logic_vector (31 downto 0)
    );
  end component;

 signal instr_rdata : dw_t;
 signal data_rdata  : dw_t;
 signal data_w_en   : std_logic;
 signal data_r_en   : std_logic;
 signal data_wdata  : dw_t;
 signal data_addr   : dw_t;
 signal instr_addr  : dw_t;
begin
  processor: mips
    port map (
      rst_i         => rst_i,
      ck_i          => ck_i,
      instr_rdata_i => instr_rdata,
      data_rdata_i  => data_rdata,

      data_w_en_o   => data_w_en,
      data_r_en_o   => data_r_en,
      data_wdata_o  => data_wdata,
      data_addr_o   => data_addr,
      instr_addr_o  => instr_addr
    );

  datamem: mips_ram
    port map
    (
      address => data_addr(7 downto 0),
      clock   => mem_ck_i,
      data    => data_wdata,
      wren    => data_w_en,
      q       => data_rdata
    );

  instrmem: mips_rom
    generic map
    (
      init_file => init_file
    )
    port map
    (
      address => instr_addr(11 downto 2), --Addressing is word-based
      clock   => ck_i,
      q       => instr_rdata
    );
end architecture;

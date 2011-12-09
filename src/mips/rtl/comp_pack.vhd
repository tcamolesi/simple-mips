library ieee;
use ieee.std_logic_1164.all;

use work.core_pack.all;
use work.alu_pack.all;
use work.control_pack.all;

package comp_pack is

--------------------------------------------------------------------------------
-- Registers
--------------------------------------------------------------------------------

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

  component reg_bank_3port is
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
  end component;

--------------------------------------------------------------------------------
-- ALU
--------------------------------------------------------------------------------

  component alu is
    port (
      op1_i     : in  dw_t;      -- First operand
      op2_i     : in  dw_t;      -- Second operand
      func_i    : in  alu_op_t;  -- Operation

      res_o     : out dw_t;      -- Result
      zf_o      : out std_logic; -- Zero flag
      bf_o      : out std_logic  -- Borrow flag
    );
  end component;

  component alu_control is
    port (
      alucontrol_i    : in instruction_t;
      funct_i         : in funct_t;

      aluop_o         : out alu_op_t
     );
  end component;

--------------------------------------------------------------------------------
-- Control Unit
--------------------------------------------------------------------------------

  component control_unit is
    port (
      op_i            : in  opcode_t;

      reg_dst_o       : out std_logic;
      branch_o        : out std_logic;
      mem_to_reg_o    : out std_logic;
      mem_r_o         : out std_logic;
      mem_wr_o        : out std_logic;
      alu_src_o       : out std_logic;
      reg_wr_o        : out std_logic;
      jump_o          : out std_logic;
      alucontrol_o    : out instruction_t
     );
  end component;

--------------------------------------------------------------------------------
-- Instruction Decoder
--------------------------------------------------------------------------------

  component intruction_decoder is
    port (
      instr_i     : in  dw_t;

      op_o        : out opcode_t;
      rs_o        : out reg_id_t;
      rt_o        : out reg_id_t;
      rd_o        : out reg_id_t;
      funct_o     : out funct_t;
      immed_o     : out immed_t;
      j_targ_o    : out j_targ_t
     );
  end component;
end package;

package body comp_pack is
end package body;

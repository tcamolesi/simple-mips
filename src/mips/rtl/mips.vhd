library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.alu_pack.all;
use work.core_pack.all;
use work.comp_pack.all;
use work.control_pack.all;
use work.glue_pack.all;

entity mips is
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
end mips;

architecture structural of mips is
  -- Decoded from instruction
  signal op          : opcode_t;
  signal rs          : reg_id_t;
  signal rt          : reg_id_t;
  signal rd          : reg_id_t;
  signal funct       : funct_t;
  signal immed       : immed_t;

  -- Write register selector
  signal rw_sel      : reg_id_t;

  -- Extended and shifted immed
  signal immed_ext   : dw_t;
  signal immed_sl2   : dw_t;

  -- PC
  signal pc_d        : dw_t; -- PC in
  signal pc_q        : dw_t; -- PC out
  signal pc_p4       : dw_t; -- PC + 4
  signal pc_branch   : dw_t; -- PC + immed_sl2 (for branching)

  -- Control unit signals
  signal reg_dst     : std_logic;
  signal branch      : std_logic;
  signal mem_to_reg  : std_logic;
  signal alup        : std_logic;
  signal mem_r       : std_logic;
  signal mem_wr      : std_logic;
  signal alu_src     : std_logic;
  signal reg_wr      : std_logic;
  signal alucontrol  : instruction_t;

  -- Register bank
  signal reg_q0      : dw_t; -- Port 0 output
  signal reg_q1      : dw_t; -- Port 1 output
  signal reg_w_data  : dw_t; -- Write data

  -- ALU
  signal aluop       : alu_op_t;  -- ALU operation selector
  signal alu_oper2   : dw_t;      -- Second ALU operand
  signal alu_res     : dw_t;      -- ALU result
  signal zf          : std_logic; -- Zero flag
  signal bf          : std_logic; -- Borrow flag

  signal branch_mux_sel : std_logic;
begin
--------------------------------------------------------------------------------
-- Muxes
--------------------------------------------------------------------------------
  branch_mux: mux_2port
    generic map (
      bus_width_g => dw_t'length
    )
    port map (
      d0_i  => pc_p4,
      d1_i  => pc_branch,
      sel_i => branch_mux_sel,

      q_o   => pc_d
    );

  reg_dst_mux: mux_2port
    generic map (
      bus_width_g => rt'length
    )
    port map (
      d0_i  => rt,
      d1_i  => rd,
      sel_i => reg_dst,

      q_o   => rw_sel
    );

  alu_src_mux: mux_2port
    generic map (
      bus_width_g => dw_t'length
    )
    port map (
      d0_i  => reg_q1,
      d1_i  => immed_ext,
      sel_i => alu_src,

      q_o   => alu_oper2
    );

  mem_to_reg_mux: mux_2port
    generic map (
      bus_width_g => dw_t'length
    )
    port map (
      d0_i  => data_rdata_i,
      d1_i  => alu_res,
      sel_i => mem_to_reg,

      q_o   => reg_w_data
    );

--------------------------------------------------------------------------------
-- Instruction decoder
--------------------------------------------------------------------------------
  instr_dec: intruction_decoder
    port map (
      instr_i => instr_rdata_i,
      op_o    => op,
      rs_o    => rs,
      rt_o    => rt,
      rd_o    => rd,
      funct_o => funct,
      immed_o => immed
    );

--------------------------------------------------------------------------------
-- Registers
--------------------------------------------------------------------------------
  the_pc: reg_g
    generic map (
      nbits_g => dw_t'length
    )
    port map (
      d_i     => pc_d,
      ck_i    => ck_i,
      rst_i   => rst_i,
      wr_en_i => '1',
      q_o     => pc_q
    );

  reg_bank: reg_bank_3port
    generic map (
      sel_bits_g => 5
    )
    port map (
       r0_sel => rs,
       r1_sel => rt,
       rw_sel => rw_sel,
       d_i    => reg_w_data,
       we_i   => reg_wr,
       ck_i   => ck_i,
       rst_i  => rst_i,

       q0_o   => reg_q0,
       q1_o   => reg_q1
  );

--------------------------------------------------------------------------------
-- ALU
--------------------------------------------------------------------------------
  alu_cnt: alu_control
    port map (
      alucontrol_i => alucontrol,
      funct_i      => funct,

      aluop_o      => aluop
     );

  the_alu: alu
    port map (
      op1_i  => reg_q0,
      op2_i  => alu_oper2,
      func_i => aluop,

      res_o  => alu_res,
      zf_o   => zf,
      bf_o   => bf
    );

  control: control_unit
    port map (
      op_i         => op,

      reg_dst_o    => reg_dst,
      branch_o     => branch,
      mem_to_reg_o => mem_to_reg,
      mem_r_o      => mem_r,
      mem_wr_o     => mem_wr,
      alu_src_o    => alu_src,
      reg_wr_o     => reg_wr,
      alucontrol_o => alucontrol
     );
--------------------------------------------------------------------------------
-- Glue Logic
--------------------------------------------------------------------------------
  pc_adder: adder_g
    generic map (
      bus_width_g => dw_t'length
    )
    port map (
      d1_i => pc_q,
      d2_i => std_logic_vector(to_unsigned(4, dw_t'length)),

      q_o  => pc_p4
    );

  branch_adder: adder_g
    generic map (
      bus_width_g => dw_t'length
    )
    port map (
      d1_i => pc_p4,
      d2_i => immed_sl2,

      q_o  => pc_branch
    );

  immed_extender: sign_extender
    generic map (
      inp_width_g   => immed'length,
      outp_width_g  => dw_t'length
    )
    port map (
      d_i => immed,

      q_o => immed_ext
     );

  immed_shifter: left_shifter
    generic map (
      shift_amount_g => 2,
      bus_width_g    => dw_t'length
    )
    port map (
      d_i => immed_ext,
      q_o => immed_sl2
    );

--------------------------------------------------------------------------------
-- Output signals
--------------------------------------------------------------------------------
  data_w_en_o  <= mem_wr;
  data_r_en_o  <= mem_r;
  data_addr_o  <= alu_res;
  data_wdata_o <= reg_q1;
  instr_addr_o <= pc_q;
  branch_mux_sel <= branch and zf;
end architecture;

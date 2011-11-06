library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PROCESSOR is
port( 
      INPUT  : in STD_LOGIC_VECTOR (31 downto 0);
		CLK_H  : in STD_LOGIC;
		RST_H  : in STD_LOGIC;
		IR: in STD_LOGIC_VECTOR (31 downto 0);
	   DATAADD: out STD_LOGIC_VECTOR (31 downto 0);
		INSTADD: out STD_LOGIC_VECTOR (31 downto 0);
		OVERFLOW: out STD_LOGIC;
		MEMWR : out STD_LOGIC;
      OUTPUT : out STD_LOGIC_VECTOR (31 downto 0)
);
end PROCESSOR;

use WORK.all;

architecture BEHAVIORAL of PROCESSOR is

component ALU is 
  port ( 
    DATA1: 		in STD_LOGIC_VECTOR (31 downto 0);
	 DATA2: 		in STD_LOGIC_VECTOR (31 downto 0);
	 FUNC: 		in STD_LOGIC_VECTOR (3 downto 0);
	 SHIFTVAL: 	in STD_LOGIC_VECTOR (4 downto 0);
	 ZERO: 		out STD_LOGIC;
	 NZERO: out STD_LOGIC;
	 LESS: 		out STD_LOGIC;
	 NEGAT: 		out STD_LOGIC;
	 GT:			out STD_LOGIC;
	 RESULT: 	out STD_LOGIC_VECTOR (31 downto 0);
	 OVERFLOW: 	out STD_LOGIC
);

end component;


component BRANCH_ADD is
	port (
		INPUT1:	in STD_LOGIC_VECTOR (31 downto 0);
		INPUT2:	in STD_LOGIC_VECTOR (31 downto 0);
		RESULT:	out STD_LOGIC_VECTOR (31 downto 0)
);
end component;


component CONTROL is
    port ( OP : in STD_LOGIC_VECTOR(5 downto 0);
           FUNCT : in STD_LOGIC_VECTOR (5 downto 0);
	 		  INST : in STD_LOGIC;
			  ZERO : in STD_LOGIC;
         NZERO : in STD_LOGIC;
			  NEGAT : in STD_LOGIC;
			  GT :  in STD_LOGIC;
			  LESS : in STD_LOGIC;
           SIGEXT : out STD_LOGIC;
           SETCONT : out STD_LOGIC_VECTOR(1 downto 0);
           REGDST : out STD_LOGIC_VECTOR(1 downto 0);
           WRITEBACK : out STD_LOGIC_VECTOR(2 downto 0);
           ALUOP : out STD_LOGIC_VECTOR(2 downto 0);
           MEMWRITE : out STD_LOGIC;
           ALUSRC : out STD_LOGIC;
           REGWRITE : out STD_LOGIC;
			  PCSRC : out STD_LOGIC_VECTOR(1 downto 0)
);
end component;

component ALU_CONTROL is
    port ( ALUOP : in STD_LOGIC_VECTOR(2 downto 0);
	   	  FUNCT : in STD_LOGIC_VECTOR (5 downto 0);
           ALUCONTOUT : out STD_LOGIC_VECTOR (3 downto 0);
			  OP : in STD_LOGIC_VECTOR (5 downto 0)
);
end component;


component REG_FILE is
port (
	WE_H: in STD_LOGIC;
	CLK_H: in STD_LOGIC;
	RST_H: in STD_LOGIC;

	REG_SS_SEL: in STD_LOGIC_VECTOR(4 downto 0);
	REG_ST_SEL: in STD_LOGIC_VECTOR(4 downto 0);
	REG_D_SEL: in STD_LOGIC_VECTOR(4 downto 0);
	DATA_IN: in STD_LOGIC_VECTOR(31 downto 0);

	REG_S_OUT: out STD_LOGIC_VECTOR(31 downto 0);
	REG_T_OUT: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;


component LEFT_EXT is
port (
	SIGN_EXT_H: in STD_LOGIC;
	REG_16_IN: in STD_LOGIC_VECTOR(15 downto 0);	
	REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;

component PC is
	port (
		INPUT:	in STD_LOGIC_VECTOR (31 downto 0);
		THE_PC:	out STD_LOGIC_VECTOR (31 downto 0);
		CLK_H:	in STD_LOGIC;
		RESET:	in STD_LOGIC
);
end component;

component PC_ADD is
	port (
		PC:		in STD_LOGIC_VECTOR (31 downto 0);
		RESULT:	out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component PC_CONT_MX is
port (
	CSEL_H: in STD_LOGIC_VECTOR(1 downto 0);
	REG_A_IN: in STD_LOGIC_VECTOR(31 downto 0);	
	REG_B_IN: in STD_LOGIC_VECTOR(31 downto 0);	
	REG_C_IN: in STD_LOGIC_VECTOR(31 downto 0);	
	REG_D_IN: in STD_LOGIC_VECTOR(31 downto 0);
	REG_SEL: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;

component REG_CONT_MX is
port (
	CSEL_H: in STD_LOGIC_VECTOR (1 downto 0);
	REG_A_IN: in STD_LOGIC_VECTOR(4 downto 0);	
	REG_B_IN: in STD_LOGIC_VECTOR(4 downto 0);	

	REG_SEL: out STD_LOGIC_VECTOR(4 downto 0)
);
end component;



component REG_DATA_MX is
port (
	CSEL_H: in STD_LOGIC;
	REG_A_IN: in STD_LOGIC_VECTOR(31 downto 0);	
	REG_B_IN: in STD_LOGIC_VECTOR(31 downto 0);	

	REG_SEL: out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;


component RIGHT_EXT is
port (
	REG_16_IN: in STD_LOGIC_VECTOR(15 downto 0);	
	REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;


component SET_CONT_MX is
port (
	CSEL_H: in STD_LOGIC_VECTOR(1 downto 0);

	SIG_A: in STD_LOGIC;
	SIG_B: in STD_LOGIC;
	SIG_C: in STD_LOGIC;
	SIG_D: in STD_LOGIC;

	SIG_SEL: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;


component WRITE_CONT_MX is
port (
	CSEL_H: in STD_LOGIC_VECTOR(2 downto 0);

	SIG_A: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_B: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_C: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_D: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_E: in STD_LOGIC_VECTOR(31 downto 0);
	SIG_F: in STD_LOGIC_VECTOR(31 downto 0);

	SIG_SEL: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;


component LEFT_SHIFT is
port (
	REG_26_IN: in STD_LOGIC_VECTOR(25 downto 0);	
	REG_B_IN: in STD_LOGIC_VECTOR(3 downto 0);
	REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;

-- Control Signals
signal TREG_WRITE: STD_LOGIC;
signal TALUSRC: STD_LOGIC;
signal TMEMWRITE: STD_LOGIC;
signal TALUOP: STD_LOGIC_VECTOR(2 downto 0);
signal TWRITEBACK: STD_LOGIC_VECTOR(2 downto 0);
signal TREGDST: STD_LOGIC_VECTOR(1 downto 0);
signal TSETCONT: STD_LOGIC_VECTOR(1 downto 0);
signal TSIGEXT: STD_LOGIC;
signal TINST: STD_LOGIC_VECTOR(31 downto 0);
signal TPCSRC: STD_LOGIC_VECTOR(1 downto 0);
signal TZERO: STD_LOGIC;
signal TNZERO: STD_LOGIC;
signal TNEGAT: STD_LOGIC;
signal TLESS: STD_LOGIC;
signal TGT: STD_LOGIC;

--ALU SIGNALS
signal ALU_RES: STD_LOGIC_VECTOR(31 downto 0);
signal OVER: STD_LOGIC;

-- BRANCH ADDER SIGNALS
signal BADDRES: STD_LOGIC_VECTOR(31 downto 0);

-- REGISTER FILE SIGNALS
signal TRS: STD_LOGIC_VECTOR(31 downto 0);
signal TRT: STD_LOGIC_VECTOR(31 downto 0);

-- LEFT EXTENDER SIGNALS
signal TEXTRES: STD_LOGIC_VECTOR(31 downto 0);

-- PC SIGNALS
signal TPCOUT: STD_LOGIC_VECTOR(31 downto 0);

-- PC ADD SIGNALS
signal TNEWPC: STD_LOGIC_VECTOR(31 downto 0);

-- PC_CONT_MX SIGNALS
signal TOUTPC: STD_LOGIC_VECTOR(31 downto 0);

-- REGISTER CONTROL MUX SIGNALS
signal TOUTREG: STD_LOGIC_VECTOR(4 downto 0);

-- REGISTER DATA MUX SIGNALS
signal TOUTALU: STD_LOGIC_VECTOR(31 downto 0);

-- RIGHT EXTENDER SIGNALS
signal TOUTREXT: STD_LOGIC_VECTOR(31 downto 0);

-- SET CONTROL MUX SIGNALS
signal TSETOUT: STD_LOGIC_VECTOR(31 downto 0);

-- WRITE BACK CONTROL MUX SIGNALS
signal TOUTWB: STD_LOGIC_VECTOR(31 downto 0);

-- ALU CONTROLLER SIGNALS
signal TALUFUNC: STD_LOGIC_VECTOR(3 downto 0);

-- LEFTSHIFT SIGNALS
signal TLSOUT: STD_LOGIC_VECTOR(31 downto 0);
signal TOUTPUT: STD_LOGIC_VECTOR(31 downto 0);

begin


OUR_ALU: ALU
port map(
	DATA1 => TRS,
	DATA2 => TOUTALU, 
	FUNC => TALUFUNC,
	SHIFTVAL => IR(10 downto 6),
	ZERO => TZERO,
   NZERO => TNZERO,
	NEGAT => TNEGAT, 
	GT => TGT,
	LESS => TLESS,
	RESULT => ALU_RES,
	OVERFLOW => OVER
  );



OUR_BRANCHER: BRANCH_ADD
port map(
	INPUT1 => TNEWPC,
	INPUT2 => TEXTRES,
   RESULT => BADDRES
);



OUR_CONTROLLER: CONTROL
port map(
	OP => IR(31 downto 26),
	FUNCT => IR(5 downto 0),
	INST => IR(16),
	ZERO => TZERO,
   NZERO => TNZERO,
	NEGAT => TNEGAT,
	GT => TGT,
	LESS => TLESS,
	SIGEXT => TSIGEXT,
	SETCONT => TSETCONT,
	REGDST => TREGDST,
	WRITEBACK => TWRITEBACK,
	ALUOP => TALUOP,
	MEMWRITE => TMEMWRITE,
	ALUSRC => TALUSRC,
	REGWRITE => TREG_WRITE,
	PCSRC => TPCSRC
);

OUR_ALUCONT: ALU_CONTROL
port map(
	ALUOP => TALUOP,
	FUNCT => IR(5 downto 0),
	ALUCONTOUT => TALUFUNC,
	OP => IR (31 downto 26)
);

OUR_REGISTERS : REG_FILE
port map(
	WE_H => TREG_WRITE,
	CLK_H => CLK_H,
	RST_H => RST_H,
	REG_SS_SEL => IR(25 downto 21),
	REG_ST_SEL => IR(20 downto 16),
	REG_D_SEL => TOUTREG,
	DATA_IN => TOUTWB,
	REG_S_OUT => TRS,
	REG_T_OUT => TRT
);


OUR_LEXTENDER : LEFT_EXT
port map(
	SIGN_EXT_H => TSIGEXT,
	REG_16_IN => IR(15 downto 0),
	REG_32_OUT => TEXTRES
);


OUR_PC: PC
port map(
	INPUT => TOUTPC,
	THE_PC => TPCOUT,
	CLK_H => CLK_H,
	RESET => RST_H
);


OUR_PCADDER: PC_ADD
port map(
	PC => TPCOUT,
	RESULT => TNEWPC
);


OUR_PCCONTMUX: PC_CONT_MX
port map(
	CSEL_H => TPCSRC,
   REG_A_IN => TNEWPC,
	REG_B_IN => TLSOUT,
   REG_C_IN => TRS,
	REG_D_IN => BADDRES,
	REG_SEL => TOUTPC
);



OUR_REGCONTMUX: REG_CONT_MX
port map(
	CSEL_H => TREGDST,
	REG_A_IN => IR(20 downto 16),
	REG_B_IN => IR(15 downto 11),
	REG_SEL => TOUTREG
);


OUR_ALUCONTMUX: REG_DATA_MX
port map(
	CSEL_H => TALUSRC,
	REG_A_IN => TRT,
	REG_B_IN => TEXTRES,
   REG_SEL => TOUTALU
);



OUR_REXTENDER: RIGHT_EXT
port map(
	REG_16_IN => IR(15 downto 0),
	REG_32_OUT => TOUTREXT
);


OUR_SETCONTMUX: SET_CONT_MX
port map(
	CSEL_H => TSETCONT,
	SIG_A => TZERO,
   SIG_B => TLESS,
	SIG_C => TNZERO,
	SIG_D => TGT,
	SIG_SEL => TSETOUT
);



OUR_WRITERMUX: WRITE_CONT_MX
port map(
	CSEL_H => TWRITEBACK,
	SIG_A => ALU_RES,
   SIG_B => INPUT,
	SIG_C => TSETOUT,
	SIG_D => TNEWPC,
	SIG_E => TOUTREXT,
	SIG_F => TEXTRES,
	SIG_SEL => TOUTWB
);


OUR_LEFTSHIFTER: LEFT_SHIFT
port map(
	REG_26_IN => IR(25 downto 0),
	REG_B_IN => TNEWPC(31 downto 28),
	REG_32_OUT => TLSOUT
);

OUTPUT <= TRT;
OVERFLOW <= OVER;
MEMWR <= TMEMWRITE;
DATAADD <= ALU_RES;
INSTADD <= TPCOUT;
end BEHAVIORAL;

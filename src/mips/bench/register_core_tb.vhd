
-- VHDL Test Bench Created from source file instr_reg_core.vhd -- 20:14:50 10/19/2002
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT instr_reg_core
	PORT(
		WE_H : IN std_logic;
		CLK_H : IN std_logic;
		RST_H : IN std_logic;
		REG_SS_SEL : IN std_logic_vector(4 downto 0);
		REG_ST_SEL : IN std_logic_vector(4 downto 0);
		REG_D_SEL : IN std_logic_vector(4 downto 0);
		DATA_IN : IN std_logic_vector(31 downto 0);          
		REG_S_OUT : OUT std_logic_vector(31 downto 0);
		REG_T_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	SIGNAL WE_H :  std_logic;
	SIGNAL CLK_H :  std_logic;
	SIGNAL RST_H :  std_logic;
	SIGNAL REG_SS_SEL :  std_logic_vector(4 downto 0);
	SIGNAL REG_ST_SEL :  std_logic_vector(4 downto 0);
	SIGNAL REG_D_SEL :  std_logic_vector(4 downto 0);
	SIGNAL DATA_IN :  std_logic_vector(31 downto 0);
	SIGNAL REG_S_OUT :  std_logic_vector(31 downto 0);
	SIGNAL REG_T_OUT :  std_logic_vector(31 downto 0);
	
	constant CLK_PERIOD : time:= 20 ns;

BEGIN

	uut: instr_reg_core PORT MAP(
		WE_H => WE_H,
		CLK_H => CLK_H,
		RST_H => RST_H,
		REG_SS_SEL => REG_SS_SEL,
		REG_ST_SEL => REG_ST_SEL,
		REG_D_SEL => REG_D_SEL,
		DATA_IN => DATA_IN,
		REG_S_OUT => REG_S_OUT,
		REG_T_OUT => REG_T_OUT
	);


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
			WE_H <= '0';
		wait for CLK_PERIOD;
 			WE_H <= '1';
	   wait for CLK_PERIOD * 256; -- will wait forever
   END PROCESS;

  	clock : PROCESS
	BEGIN
		CLK_H <= '1';
	wait for CLK_PERIOD;
		CLK_H <= '0';
	wait for CLK_PERIOD;
	END PROCESS;

	rst : PROCESS
	BEGIN
		RST_H <= '1';
	wait for CLK_PERIOD * 2;
		RST_H <= '0';
	wait for CLK_PERIOD * 16;
	END PROCESS;

	data : PROCESS
	BEGIN
			DATA_IN <= X"0000FFFF";
		wait for CLK_PERIOD*4;
			DATA_IN <=X"FFFF0000";
	END PROCESS;

	clocks : PROCESS
	BEGIN
		wait for CLK_PERIOD * 2;
			REG_D_SEL <= "00000";
			REG_SS_SEL <= "00000";
			REG_ST_SEL <= "00001";
		wait for CLK_PERIOD * 8;
			REG_D_SEL <= "00001";
	 END PROCESS;
	-- *** End Test Bench - User Defined Section ***

END;

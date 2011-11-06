
-- VHDL Test Bench Created from source file left_ext.vhd -- 21:19:09 10/19/2002
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

	COMPONENT left_ext
	PORT(
		SIGN_EXT_H : IN std_logic;
		REG_16_IN : IN std_logic_vector(15 downto 0);          
		REG_32_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	SIGNAL SIGN_EXT_H :  std_logic;
	SIGNAL REG_16_IN :  std_logic_vector(15 downto 0);
	SIGNAL REG_32_OUT :  std_logic_vector(31 downto 0);

BEGIN

	uut: left_ext PORT MAP(
		SIGN_EXT_H => SIGN_EXT_H,
		REG_16_IN => REG_16_IN,
		REG_32_OUT => REG_32_OUT
	);


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;

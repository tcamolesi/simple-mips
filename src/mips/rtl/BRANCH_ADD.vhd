library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity BRANCH_ADD is
	port (
		INPUT1:	in STD_LOGIC_VECTOR (31 downto 0);
		INPUT2:	in STD_LOGIC_VECTOR (31 downto 0);
		RESULT:	out STD_LOGIC_VECTOR (31 downto 0)
);
end BRANCH_ADD;

use WORK.all;

architecture BEHAVIORAL of BRANCH_ADD is

signal I2: STD_LOGIC_VECTOR (31 downto 0);

begin

	I2 <= INPUT2 (29 downto 0) & "00";	-- shift left 2
	RESULT <= INPUT1 + I2;

end BEHAVIORAL;



--Somador Completo 32Bits

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity FS32 is
	port (
		REG1: in STD_LOGIC_VECTOR (31 downto 0);
		REG2: in STD_LOGIC_VECTOR (31 downto 0);
		BIN: in STD_LOGIC;
		QUOTIENT: out STD_LOGIC_VECTOR (31 downto 0);
		BOUT: out STD_LOGIC
	  );
end FS32;



architecture BEHAVIORAL of FS32 is

component FS8 is
					port(
							A: in STD_LOGIC_VECTOR(7 downto 0);
							B: in STD_LOGIC_VECTOR(7 downto 0);
							BIN: in STD_LOGIC;
							FOUT: out STD_LOGIC_VECTOR (7 downto 0);
 						   BOUT: out STD_LOGIC
							);
end component;

signal RESULT: STD_LOGIC_VECTOR(31 downto 0);
signal BOUT1: STD_LOGIC;
signal BOUT2: STD_LOGIC;
signal BOUT3: STD_LOGIC;
signal BOUT4: STD_LOGIC;


begin
	
A1: FS8
	port map(
		A => REG1(7 downto 0),
		B => REG2(7 downto 0),
		BIN => BIN,
 	   FOUT => RESULT (7 downto 0),
 	   BOUT => BOUT1
	);

A2: FS8
	port map(
		A => REG1(15 downto 8),
		B => REG2(15 downto 8),
		BIN => BOUT1,
 	   FOUT => RESULT (15 downto 8),
 	   BOUT => BOUT2
	);


A3: FS8
	port map(
		A => REG1(23 downto 16),
		B => REG2(23 downto 16),
		BIN => BOUT2,
 	   FOUT => RESULT (23 downto 16),
 	   BOUT => BOUT3
	);

A4: FS8
	port map(
		A => REG1(31 downto 24),
		B => REG2(31 downto 24),
		BIN => BOUT3,
 	   FOUT => RESULT (31 downto 24),
 	   BOUT => BOUT4
	);


BOUT <= BOUT4;
QUOTIENT <= RESULT;

end BEHAVIORAL;


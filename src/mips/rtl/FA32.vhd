--Somador compledo de 32 bits

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity FA32 is
	port (
		REG1: in STD_LOGIC_VECTOR (31 downto 0);
		REG2: in STD_LOGIC_VECTOR (31 downto 0);
		CIN: in STD_LOGIC;
		SUM: out STD_LOGIC_VECTOR (31 downto 0);
		COUT: out STD_LOGIC
	  );
end FA32;



architecture BEHAVIORAL of FA32 is

component FA8 is
					port(
							A: in STD_LOGIC_VECTOR(7 downto 0);
							B: in STD_LOGIC_VECTOR(7 downto 0);
							CIN: in STD_LOGIC;
							FOUT: out STD_LOGIC_VECTOR (7 downto 0);
 						   COUT: out STD_LOGIC
							);
end component;

signal RESULT: STD_LOGIC_VECTOR(31 downto 0);
signal COUT1: STD_LOGIC;
signal COUT2: STD_LOGIC;
signal COUT3: STD_LOGIC;
signal COUT4: STD_LOGIC;


begin
	
A1: FA8
	port map(
		A => REG1(7 downto 0),
		B => REG2(7 downto 0),
		CIN => CIN,
 	   FOUT => RESULT (7 downto 0),
 	   COUT => COUT1
	);

A2: FA8
	port map(
		A => REG1(15 downto 8),
		B => REG2(15 downto 8),
		CIN => COUT1,
 	   FOUT => RESULT (15 downto 8),
 	   COUT => COUT2
	);


A3: FA8
	port map(
		A => REG1(23 downto 16),
		B => REG2(23 downto 16),
		CIN => COUT2,
 	   FOUT => RESULT (23 downto 16),
 	   COUT => COUT3
	);

A4: FA8
	port map(
		A => REG1(31 downto 24),
		B => REG2(31 downto 24),
		CIN => COUT3,
 	   FOUT => RESULT (31 downto 24),
 	   COUT => COUT4
	);


COUT <= COUT4;
SUM <= RESULT;

end BEHAVIORAL;



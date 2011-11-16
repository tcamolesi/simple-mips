library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ALU_CONTROL is
    port ( ALUOP : in STD_LOGIC_VECTOR(2 downto 0);
	   	     FUNCT : in STD_LOGIC_VECTOR (5 downto 0);
           ALUCONTOUT : out STD_LOGIC_VECTOR (3 downto 0);
			    OP : in STD_LOGIC_VECTOR (5 downto 0)
     );
end ALU_CONTROL;

architecture BEHAVIORAL of ALU_CONTROL is
begin
	ALUCONTOUT <= "0000" when (ALUOP = "000" and (FUNCT = "100000" or FUNCT = "100001")) or
						           (ALUOP = "010") or
 									  (ALUOP = "001" and OP = "001000") else
					  "0010" when (ALUOP = "000" and FUNCT = "100100") or
					   			  (ALUOP = "001" and OP = "001100") else
					  "0011" when (ALUOP = "000" and FUNCT = "100101") or 
					  				  (ALUOP = "001" and OP = "001101") else
					  "0100" when ALUOP = "000" and FUNCT = "000000" else
					  "0101" when ALUOP = "000" and FUNCT = "000010" else
					  "0110" when (ALUOP = "000" and FUNCT = "100110") or
 					  				  (ALUOP = "001" and OP = "001110") else
					  "0111" when ALUOP = "000" and FUNCT = "100111" else
					  "1000" when ALUOP = "000" and FUNCT = "000011" else
					  "1001" when ALUOP = "000" and FUNCT = "010101" else
					  "1010" when ALUOP = "000" and FUNCT = "010110" else
						"1011" when (ALUOP = "000" and FUNCT = "100001") or 
											(ALUOP = "001" and OP = "001001") else
						"1100" when (ALUOP = "000" and (FUNCT = "100011" or FUNCT = "101011")) or
											(ALUOP = "001" and OP = "001011") else
				
					  "0001";
end BEHAVIORAL;

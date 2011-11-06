library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REG_FILE is
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
end REG_FILE;

architecture BEHAVIORAL of REG_FILE is
--------------------------------------------
-- Component declarations.
--------------------------------------------

--------------------------------------------
-- Signal declarations.
--------------------------------------------

-- INTERNAL REGISTERS.
	signal REG00: STD_LOGIC_VECTOR(31 downto 0);
	signal REG01: STD_LOGIC_VECTOR(31 downto 0);
	signal REG02: STD_LOGIC_VECTOR(31 downto 0);
	signal REG03: STD_LOGIC_VECTOR(31 downto 0);
	signal REG04: STD_LOGIC_VECTOR(31 downto 0);
	signal REG05: STD_LOGIC_VECTOR(31 downto 0);
	signal REG06: STD_LOGIC_VECTOR(31 downto 0);
	signal REG07: STD_LOGIC_VECTOR(31 downto 0);
	signal REG08: STD_LOGIC_VECTOR(31 downto 0);
	signal REG09: STD_LOGIC_VECTOR(31 downto 0);
	signal REG10: STD_LOGIC_VECTOR(31 downto 0);
	signal REG11: STD_LOGIC_VECTOR(31 downto 0);
	signal REG12: STD_LOGIC_VECTOR(31 downto 0);
	signal REG13: STD_LOGIC_VECTOR(31 downto 0);
	signal REG14: STD_LOGIC_VECTOR(31 downto 0);
	signal REG15: STD_LOGIC_VECTOR(31 downto 0);
	signal REG16: STD_LOGIC_VECTOR(31 downto 0);
	signal REG17: STD_LOGIC_VECTOR(31 downto 0);
	signal REG18: STD_LOGIC_VECTOR(31 downto 0);
	signal REG19: STD_LOGIC_VECTOR(31 downto 0);
	signal REG20: STD_LOGIC_VECTOR(31 downto 0);
	signal REG21: STD_LOGIC_VECTOR(31 downto 0);
	signal REG22: STD_LOGIC_VECTOR(31 downto 0);
	signal REG23: STD_LOGIC_VECTOR(31 downto 0);
	signal REG24: STD_LOGIC_VECTOR(31 downto 0);
	signal REG25: STD_LOGIC_VECTOR(31 downto 0);
	signal REG26: STD_LOGIC_VECTOR(31 downto 0);
	signal REG27: STD_LOGIC_VECTOR(31 downto 0);
	signal REG28: STD_LOGIC_VECTOR(31 downto 0);
	signal REG29: STD_LOGIC_VECTOR(31 downto 0);
	signal REG30: STD_LOGIC_VECTOR(31 downto 0);
	signal REG31: STD_LOGIC_VECTOR(31 downto 0);

-- END INTERNAL REGISTERS.
	signal ERRFLAG: STD_LOGIC;	
--------------------------------------------
-- Module Implementation.
--------------------------------------------
begin -- BEGIN ARCHITECTURE

core_reg:PROCESS(CLK_H, RST_H, REG_SS_SEL)
	begin
		if RST_H = '1' then
			case RST_H is
				when '1' =>
				REG00 <= X"00000000";
				REG01 <= X"00000000";
				REG02 <= X"00000000";
				REG03 <= X"00000000";
				REG04 <= X"00000000";
				REG05 <= X"00000000";
				REG06 <= X"00000000";
				REG07 <= X"00000000";
				REG08 <= X"00000000";
				REG09 <= X"00000000";
				REG10 <= X"00000000";
				REG11 <= X"00000000";
				REG12 <= X"00000000";
				REG13 <= X"00000000";
				REG14 <= X"00000000";
				REG15 <= X"00000000";
				REG16 <= X"00000000";
				REG17 <= X"00000000";
				REG18 <= X"00000000";
				REG19 <= X"00000000";
				REG20 <= X"00000000";
				REG21 <= X"00000000";
				REG22 <= X"00000000";
				REG23 <= X"00000000";
				REG24 <= X"00000000";
				REG25 <= X"00000000";
				REG26 <= X"00000000";
				REG27 <= X"00000000";
				REG28 <= X"00000000";
				REG29 <= X"00000000";
				REG30 <= X"00000000";
				REG31 <= X"00000000";
			when others =>
				ERRFLAG <= '0';
			end case;
		elsif WE_H = '1' and RISING_EDGE(CLK_H) then
			case REG_D_SEL is
				when "00000" =>
					REG00 <= DATA_IN;
				when "00001" =>
					REG01 <= DATA_IN;
				when "00010" =>
					REG02 <= DATA_IN;
				when "00011" =>
					REG03 <= DATA_IN;
				when "00100" =>
					REG04 <= DATA_IN;
				when "00101" =>
					REG05 <= DATA_IN;
				when "00110" =>
					REG06 <= DATA_IN;
				when "00111" =>
					REG07 <= DATA_IN;
				when "01000" =>
					REG08 <= DATA_IN;
				when "01001" =>
					REG09 <= DATA_IN;
				when "01010" =>
					REG10 <= DATA_IN;
				when "01011" =>
					REG11 <= DATA_IN;
				when "01100" =>
					REG12 <= DATA_IN;
				when "01101" =>
					REG13 <= DATA_IN;
				when "01110" =>
					REG14 <= DATA_IN;
				when "01111" =>
					REG15 <= DATA_IN;
				when "10000" =>
					REG16 <= DATA_IN;
				when "10001" =>
					REG17 <= DATA_IN;
				when "10010" =>
					REG18 <= DATA_IN;
				when "10011" =>
					REG19 <= DATA_IN;
				when "10100" =>
					REG20 <= DATA_IN;
				when "10101" =>
					REG21 <= DATA_IN;
				when "10110" =>
					REG22 <= DATA_IN;
				when "10111" =>
					REG23 <= DATA_IN;
				when "11000" =>
					REG24 <= DATA_IN;
				when "11001" =>
					REG25 <= DATA_IN;
				when "11010" =>
					REG26 <= DATA_IN;
				when "11011" =>
					REG27 <= DATA_IN;
				when "11100" =>
					REG28 <= DATA_IN;
				when "11101" =>
					REG29 <= DATA_IN;
				when "11110" =>
					REG30 <= DATA_IN;
				when "11111" =>
					REG31 <= DATA_IN;
				when others =>
					ERRFLAG <= '1';
				end case;
		end if;
	end process;
-- RESET

-----------------------------------------
-- FETCHING DATA FROM REGISTERS 
-- This takes data from one of the
-- internal registers and writes it to
-- the appropriate output bus.
-----------------------------------------
-- REG_SS_SEL
	REG_S_OUT <= REG00 when REG_SS_SEL = "00000" else
					 REG01 when REG_SS_SEL = "00001" else
					 REG02 when REG_SS_SEL = "00010" else
					 REG03 when REG_SS_SEL = "00011" else
					 REG04 when REG_SS_SEL = "00100" else
	 				 REG05 when REG_SS_SEL = "00101" else
					 REG06 when REG_SS_SEL = "00110" else
					 REG07 when REG_SS_SEL = "00111" else
					 REG08 when REG_SS_SEL = "01000" else
					 REG09 when REG_SS_SEL = "01001" else
					 REG10 when REG_SS_SEL = "01010" else
					 REG11 when REG_SS_SEL = "01111" else
					 REG12 when REG_SS_SEL = "01100" else
					 REG13 when REG_SS_SEL = "01101" else
					 REG14 when REG_SS_SEL = "01110" else
					 REG15 when REG_SS_SEL = "01111" else
					 REG16 when REG_SS_SEL = "10000" else
					 REG17 when REG_SS_SEL = "10001" else
					 REG18 when REG_SS_SEL = "10010" else
					 REG19 when REG_SS_SEL = "10011" else
					 REG20 when REG_SS_SEL = "10100" else
					 REG21 when REG_SS_SEL = "10101" else
					 REG22 when REG_SS_SEL = "10110" else
					 REG23 when REG_SS_SEL = "10111" else
					 REG24 when REG_SS_SEL = "11100" else
					 REG25 when REG_SS_SEL = "11101" else
					 REG26 when REG_SS_SEL = "11110" else
					 REG27 when REG_SS_SEL = "11111" else
					 REG28 when REG_SS_SEL = "11100" else
					 REG29 when REG_SS_SEL = "11101" else
					 REG30 when REG_SS_SEL = "11110" else
					 REG31 when REG_SS_SEL = "11111" else REG00;

-- REG_ST_SEL
	REG_T_OUT <= REG00 when REG_ST_SEL = "00000" else
					 REG01 when REG_ST_SEL = "00001" else
					 REG02 when REG_ST_SEL = "00010" else
					 REG03 when REG_ST_SEL = "00011" else
					 REG04 when REG_ST_SEL = "00100" else
	 				 REG05 when REG_ST_SEL = "00101" else
					 REG06 when REG_ST_SEL = "00110" else
					 REG07 when REG_ST_SEL = "00111" else
					 REG08 when REG_ST_SEL = "01000" else
					 REG09 when REG_ST_SEL = "01001" else
					 REG10 when REG_ST_SEL = "01010" else
					 REG11 when REG_ST_SEL = "01111" else
					 REG12 when REG_ST_SEL = "01100" else
					 REG13 when REG_ST_SEL = "01101" else
					 REG14 when REG_ST_SEL = "01110" else
					 REG15 when REG_ST_SEL = "01111" else
					 REG16 when REG_ST_SEL = "10000" else
					 REG17 when REG_ST_SEL = "10001" else
					 REG18 when REG_ST_SEL = "10010" else
					 REG19 when REG_ST_SEL = "10011" else
					 REG20 when REG_ST_SEL = "10100" else
					 REG21 when REG_ST_SEL = "10101" else
					 REG22 when REG_ST_SEL = "10110" else
					 REG23 when REG_ST_SEL = "10111" else
					 REG24 when REG_ST_SEL = "11100" else
					 REG25 when REG_ST_SEL = "11101" else
					 REG26 when REG_ST_SEL = "11110" else
					 REG27 when REG_ST_SEL = "11111" else
					 REG28 when REG_ST_SEL = "11100" else
					 REG29 when REG_ST_SEL = "11101" else
					 REG30 when REG_ST_SEL = "11110" else
					 REG31 when REG_ST_SEL = "11111" else REG00;
-- END REGISTER FETCH
end BEHAVIORAL;




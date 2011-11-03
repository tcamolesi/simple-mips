-- Design baseado na figura 2.14 (pg. 20) do documento MIPS-Implementation.pdf
library ieee;
use ieee.std_logic_1164.all;

package resources is
	type word is array (31 downto 0) of std_logic;
end resources;
use work.resources.all;

entity top_level is
	port (clk, reset: in std_logic);
end top_level;

architecture rtl of top_level is
	component instruction_memory
		port (clk:         in  std_logic;
		      read_addr:   in  word;
		      instruction: out word);
	end component;
	
	signal pc_out, instruction: word;
begin
	instr: instruction_memory
		generic map (n => 1024)
	    port map (clk => clk, read_addr => pc_out, instruction => instruction);
	                          
end rtl;

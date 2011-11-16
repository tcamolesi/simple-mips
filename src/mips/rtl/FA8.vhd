-- Somador 8 bit
-- Não a forma mais inteligente de montar

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FA8 is
  port(
    A: in STD_LOGIC_VECTOR (7 downto 0);
    B: in STD_LOGIC_VECTOR (7 downto 0);
    CIN: in STD_LOGIC;
    FOUT: out STD_LOGIC_VECTOR (7 downto 0);
    COUT: out STD_LOGIC
    );

end FA8;

use WORK.all;

architecture CAL of FA8 is

  component FA1 is
                  port (
                    A: in STD_LOGIC;
                    B: in STD_LOGIC;
                    CIN: in STD_LOGIC;
                    FOUT: out STD_LOGIC;
                    COUT: out STD_LOGIC
                    );

  end component;

  signal CO_0: STD_LOGIC;               -- out of 1st goes to in of 2nd, etc...
  signal CO_1: STD_LOGIC;
  signal CO_2: STD_LOGIC;
  signal CO_3: STD_LOGIC;
  signal CO_4: STD_LOGIC;
  signal CO_5: STD_LOGIC;
  signal CO_6: STD_LOGIC;



begin


  ADD0: FA1
    port map (
      A => A(0),
      B => B(0),
      CIN => CIN,
      FOUT => FOUT(0),
      COUT => CO_0
      );


  ADD1: FA1
    port map (
      A => A(1),
      B => B(1),
      CIN => CO_0,
      FOUT => FOUT(1),
      COUT => CO_1
      );


  ADD2: FA1
    port map (
      A => A(2),
      B => B(2),
      CIN => CO_1,
      FOUT => FOUT(2),
      COUT => CO_2
      );


  ADD3: FA1
    port map (
      A => A(3),
      B => B(3),
      CIN => CO_2,
      FOUT => FOUT(3),
      COUT => CO_3
      );


  ADD4: FA1
    port map (
      A => A(4),
      B => B(4),
      CIN => CO_3,
      FOUT => FOUT(4),
      COUT => CO_4
      );


  ADD5: FA1
    port map (
      A => A(5),
      B => B(5),
      CIN => CO_4,
      FOUT => FOUT(5),
      COUT => CO_5
      );

  ADD6: FA1
    port map (
      A => A(6),
      B => B(6),
      CIN => CO_5,
      FOUT => FOUT(6),
      COUT => CO_6
      );


  ADD7: FA1
    port map (
      A => A(7),
      B => B(7),
      CIN => CO_6,
      FOUT => FOUT(7),
      COUT => COUT
      );


end CAL;


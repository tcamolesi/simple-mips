library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FS8 is
  port(
    A: in STD_LOGIC_VECTOR (7 downto 0);
    B: in STD_LOGIC_VECTOR (7 downto 0);
    BIN: in STD_LOGIC;
    FOUT: out STD_LOGIC_VECTOR (7 downto 0);
    BOUT: out STD_LOGIC
    );

end FS8;

use WORK.all;

architecture CAL of FS8 is

  component FS1 is
                  port (
                    A: in STD_LOGIC;
                    B: in STD_LOGIC;
                    BIN: in STD_LOGIC;
                    FOUT: out STD_LOGIC;
                    BOUT: out STD_LOGIC
                    );

  end component;

  signal BO_0: STD_LOGIC;               -- out of 1st goes to in of 2nd, etc...
  signal BO_1: STD_LOGIC;
  signal BO_2: STD_LOGIC;
  signal BO_3: STD_LOGIC;
  signal BO_4: STD_LOGIC;
  signal BO_5: STD_LOGIC;
  signal BO_6: STD_LOGIC;



begin


  SUB0: FS1
    port map (
      A => A(0),
      B => B(0),
      BIN => BIN,
      FOUT => FOUT(0),
      BOUT => BO_0
      );


  SUB1: FS1
    port map (
      A => A(1),
      B => B(1),
      BIN => BO_0,
      FOUT => FOUT(1),
      BOUT => BO_1
      );


  SUB2: FS1
    port map (
      A => A(2),
      B => B(2),
      BIN => BO_1,
      FOUT => FOUT(2),
      BOUT => BO_2
      );


  SUB3: FS1
    port map (
      A => A(3),
      B => B(3),
      BIN => BO_2,
      FOUT => FOUT(3),
      BOUT => BO_3
      );


  SUB4: FS1
    port map (
      A => A(4),
      B => B(4),
      BIN => BO_3,
      FOUT => FOUT(4),
      BOUT => BO_4
      );


  SUB5: FS1
    port map (
      A => A(5),
      B => B(5),
      BIN => BO_4,
      FOUT => FOUT(5),
      BOUT => BO_5
      );

  SUB6: FS1
    port map (
      A => A(6),
      B => B(6),
      BIN => BO_5,
      FOUT => FOUT(6),
      BOUT => BO_6
      );


  SUB7: FS1
    port map (
      A => A(7),
      B => B(7),
      BIN => BO_6,
      FOUT => FOUT(7),
      BOUT => BOUT
      );


end CAL;

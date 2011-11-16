-- TestBench Template

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE <behavior> OF <testbench> IS

-- Component Declaration
  <Component Name>
  PORT(
    <port1> : IN std_logic;
    <port2> : IN std_logic_vector(3 downto 0);
    <port3> : OUT std_logic_vector(3 downto 0)
    );
  END COMPONENT;

  SIGNAL <signal1> :  std_logic;
  SIGNAL <signal2> :  std_logic_vector(3 downto 0);


BEGIN

-- Component Instantiation
  uut: <Component Name> PORT MAP(
    <port1> => <signal1>,
    <port3> => <signal2>
  );


--  Test Bench Statements
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
--  End Test Bench

END;

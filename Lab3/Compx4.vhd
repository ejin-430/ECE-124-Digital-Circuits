library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compx4 is port (
   input_A 	: in std_logic_vector (3 downto 0);
	input_B 	: in std_logic_vector (3 downto 0);
	AGTB, AEQB, ALTB 			: out std_logic
); 
end Compx4;

architecture Compx4Circuit of Compx4 is

   component Compx1 port (
		input_A, input_B 	: in std_logic;
		AGTB, AEQB, ALTB 	: out std_logic
   ); 
   end component Compx1;
	
	signal A0GTB0, A0EQB0, A0LTB0 : std_logic;
	signal A1GTB1, A1EQB1, A1LTB1 : std_logic;
	signal A2GTB2, A2EQB2, A2LTB2 : std_logic;
	signal A3GTB3, A3EQB3, A3LTB3 : std_logic;

begin

	INST1: Compx1 port map(input_A(0), input_B(0), A0GTB0, A0EQB0, A0LTB0);
	INST2: Compx1 port map(input_A(1), input_B(1), A1GTB1, A1EQB1, A1LTB1);
	INST3: Compx1 port map(input_A(2), input_B(2), A2GTB2, A2EQB2, A2LTB2);
	INST4: Compx1 port map(input_A(3), input_B(3), A3GTB3, A3EQB3, A3LTB3);
	
	AGTB <= A3GTB3 OR (A3EQB3 AND A2GTB2) OR (A3EQB3 AND A2EQB2 AND A1GTB1) OR (A3EQB3 AND A2EQB2 AND A1EQB1 AND A0GTB0);
	AEQB <= A3EQB3 AND A2EQB2 AND A1EQB1 AND A0EQB0;
	ALTB <= A3LTB3 OR (A3EQB3 AND A2LTB2) OR (A3EQB3 AND A2EQB2 AND A1LTB1) OR (A3EQB3 AND A2EQB2 AND A1EQB1 AND A0LTB0);
 
end Compx4Circuit;


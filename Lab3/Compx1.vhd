library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compx1 is port (
	input_A, input_B 	: in std_logic;
	AGTB, AEQB, ALTB 	: out std_logic
	
); 
end Compx1;

architecture Compx1Circuit of Compx1 is

begin

	AGTB <= input_A AND (NOT input_B);
	AEQB <= input_A XNOR input_B;
	ALTB <= (NOT input_A) AND input_B;
 
end Compx1Circuit;

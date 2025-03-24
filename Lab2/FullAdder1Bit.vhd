--Team 3, Erin Hu & Eva Jin
Library ieee;
USE ieee.std_logic_1164.all;

-- 1 bit full adder
-- inputs: input A, input B, carry in
-- outputs: carry out, sum
ENTITY FullAdder1Bit IS PORT (
	INPUT_B, INPUT_A, CARRY_IN 							: in std_logic;
	FULL_ADDER_CARRY_OUTPUT, FULL_ADDER_SUM_OUTPUT	: out std_logic
);
END FullAdder1Bit;	

ARCHITECTURE adder_gates of FullAdder1Bit is 

begin 
-- logic operators to get the carry out from input A, input B, and carry in
	FULL_ADDER_CARRY_OUTPUT <= (INPUT_B AND INPUT_A) OR ((INPUT_B XOR INPUT_A) AND CARRY_IN);
-- logic operators to get the sum from input A, input B, and carry in
	FULL_ADDER_SUM_OUTPUT <= (INPUT_B XOR INPUT_A) XOR CARRY_IN;


end adder_gates;

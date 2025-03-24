--Team 3, Erin Hu & Eva Jin
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 4 bit full adder
-- inputs: input A, input B, carry in
-- outputs: carry out, sum
entity full_adder_4bit is port (
   input_A 	: in std_logic_vector (3 downto 0);
	input_B 	: in std_logic_vector (3 downto 0);
	Carry_In 			: in std_logic;
	Carry_Out3 			: out std_logic; 
	SUM 					: out std_logic_vector (3 downto 0)
	
); 
end full_adder_4bit;

architecture Circuit of full_adder_4bit is

-- Components Used ---
-- 1 bit full adder
-- inputs: input A, input B, carry in
-- outputs: carry out, sum
   component FullAdder1Bit port (
		INPUT_B, INPUT_A, CARRY_IN 							: in std_logic;
		FULL_ADDER_CARRY_OUTPUT, FULL_ADDER_SUM_OUTPUT	: out std_logic
   ); 
   end component;
	
-- Create any signals, or temporary variables to be used
-- signals for each carry out
	signal Carry_Out0 : std_logic;
	signal Carry_Out1 : std_logic;
	signal Carry_Out2 : std_logic;

-- Here the circuit begins

begin
-- four instances of 1 bit full adder connected to the 4 bit full adder
-- starting at the least significant bit, add each bit of the 4 bit input using a 1 bit adder
	
	INST1: FullAdder1Bit port map(input_A(0), input_B(0), Carry_In, Carry_Out0, SUM(0));
	INST2: FullAdder1Bit port map(input_A(1), input_B(1), Carry_Out0, Carry_Out1, SUM(1));
	INST3: FullAdder1Bit port map(input_A(2), input_B(2), Carry_Out1, Carry_Out2, SUM(2));
	INST4: FullAdder1Bit port map(input_A(3), input_B(3), Carry_Out2, Carry_Out3, SUM(3));
 
end Circuit;


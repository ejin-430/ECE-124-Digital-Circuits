Library ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY Vhdl3 IS
	PORT (
		POLARITY_CTRL, IN_1, IN_2, IN_3, IN_4	:IN std_logic;
		OUT_1, OUT_2, OUT_3, OUT_4 : OUT std_logic
		);
END Vhdl3;

ARCHITECTURE simple_gates3 OF Vhdl3 IS

BEGIN

OUT_1 <= POLARITY_CTRL XNOR IN_1;
OUT_2 <= POLARITY_CTRL XNOR IN_2;
OUT_3 <= POLARITY_CTRL XNOR IN_3;
OUT_4 <= POLARITY_CTRL XNOR IN_4;

END simple_gates3;
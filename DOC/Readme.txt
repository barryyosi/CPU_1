lab4 - VHDL
Barry Yosilevich - 208725218
Eilon Toledano - 206903445

.vhd file functional description:


FA.vhd:
- performs single bit addaction/substruction/
- ports functional description:
	+ xi, yi: single binary bits to perform addaction operation between them
	+ cin: input carry - which has to be taken in consideration within the addaction/substraction operation
	+ cout: the output carry resulted in the calculation
	+ res: the addaction/ substraction result



adderSub.vhd:
- performs substraction or addaction on 2 binary vectors(representing numbers) 	 	using FAs.
- ports functional description:
 	+ sub: determines whether the modules conducts substraction or addaction ('1' for substruction; '0' addaction)
 	+ x, y: binary vectors of length n - representing numbers to be summerized or substructed ( x-y operation)
 	+ cout: carry flag, '1' if sub/add result has carry, '0' no carry
 	+ res: the add/sub result

logic.vhd:
- performs logic operations between 2 binary vectors.
- port functional description:
	+ x, y: 2 binary vectors to perform logic operations between them
	+ ALUFN: binary vector of length 3 - determines the logic operator to perform 	on/ between x and y.
	+ res: the logic operation result.

shifter.vhd:
- performs right/left logical shifting on input vector y, dec(x) times
- port functional description:
	+ y: input binary vector to be shifted (left or right).
	+ x: input binary vector representing the number of logic shifts to perform on y.
	+ ALUFN: binary vector of length 2 - determines the shift direction ("00" for left shift, "01" for right shift).
	+ cout: shifting carry result (least MSB of right shift, or lease LSB of left shift).
	+ res: binary vector - the y vector shifted dec(x) times (to the left or right).

top.vhd:
- a processing unit description, able to perform logical and arithmetic operations over 2 input vectors.
- port functional description:
	+ x,y: input binary vectors to perform logic and arithmetic operations on.
	+ ALUFN: 5 bit length binary vectors - determines which sub-unit to trigger on the x,y vectors (ALUFN(4:5)) and operation-select for the sub-unit(ALUFN(0:3))
	+ ALUout: output result binary vector
	+ Nflag, Cflag, Zflag: Negative, carry & zero flags - '1' when result(ALUOUT)
	  corresponds to any of them.

top_fpga.vhd:
	this unit is meant to create registers that connects the keys, switches and leds to the inner layer - top
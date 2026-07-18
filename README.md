RV32I Single Cycle Project
===

This is a custom 32-Bit RISK-V Single Cyle Processor. It can handle 12 instructions: ADD, SUB, AND, XOR, OR, SLL, SLT, ADDI, LW, SW, BEQ and JAL. It reads machine code instructions from an instruction memory .hex file, executes the instruction and writes to the final result to a data memory .hex file.

![alt text](<Untitled Diagram.drawio.png>)

Supported Instructions
===
***Type &emsp;&emsp; Instructions***<br>
R-Type &emsp;&emsp; `ADD`,`SUB`,`AND`,`OR`,`XOR`,`SLL`,`SLT`<br>
I-Type &emsp;&emsp; `ADDI`,`LW`<br>
S-Type &emsp;&emsp; `SW`<br>
B-Type &emsp;&emsp; `BEQ`<br>
J-Type &emsp;&emsp; `JAL`<br>
<br>
Decoding follows: [RV32 Instruction Set Listings](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv-32-64g.html)
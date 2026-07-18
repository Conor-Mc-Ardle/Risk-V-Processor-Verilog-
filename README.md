# RV32I Single Cycle Project

This is a custom 32-Bit RISK-V Single Cyle Processor. It can handle 12 instructions: ADD, SUB, AND, XOR, OR, SLL, SLT, ADDI, LW, SW, BEQ and JAL. It reads machine code instructions from an instruction memory .hex file, executes the instruction and writes to the final result to a data memory .hex file.

![alt text](<Untitled Diagram.drawio.png>)

## Supported Instructions
Type &emsp;&emsp; Instructions
***
R-Type &emsp;&emsp; `ADD`,`SUB`,`AND`,`OR`,`XOR`,`SLL`,`SLT`
***
I-Type &emsp;&emsp; `ADDI`,`LW`
***
S-Type &emsp;&emsp; `SW`
***
B-Type &emsp;&emsp; `BEQ`
***
J-Type &emsp;&emsp; `JAL`
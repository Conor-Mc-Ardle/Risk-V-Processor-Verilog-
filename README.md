RV32I Single Cycle Project
===

This is a custom 32-Bit RISK-V Single Cyle Processor. It can handle 12 instructions: ADD, SUB, AND, XOR, OR, SLL, SLT, ADDI, LW, SW, BEQ and JAL. It reads machine code instructions from an instruction memory .hex file, executes the instruction and writes to the final result to a data memory .hex file.

![alt text](<Untitled Diagram.drawio.png>)
<br>
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
<br>

Design Note: Instruction memory as a .hex file
---
Instructions are stored in `instruction_mem.hex` and loaded via `$readmemh`. This acts as an replacement for a typical CPU instruction cache for the sake of simulation. This choice allows for the test program to be easily updated and enables fututre implementation of a
simple compiler.
<br>

How to Run
===
The processor was built and tested using Icarus Verilog and GTKWave additionaly YOSYS was used for quick schematics during the build.
<br>
Run all commands in `Risc_V_Proccessor/`. The instruction memory and final data memory are loaded with a path relative to this directory.
```powershell
iverilog -o sim.vvp `
  RV32I_top_module/Top_Module.v `
  RV32I_top_module/Top_Module_Tb.v `
  ALU_Control_Unit/ALU_Control_Unit.v `
  Register_File/Register_File.v `
  Instruction_Memory/Instruction_Mem.v `
  Immediate_Gen/Immediate_Gen.v `
  Program_Counter/PC.v `
  ALU_1/ALU_Module.v `
  Data_Module/Data_Module.v

vvp sim.vvp
gtkwave dump.vcd
```
<br>
This compiles the full processor. It runs the current program in `instruction_mem.hex`, it prints a per-cycle trace to the terminal, dumps the waveform to `dump.vcd, and writes the final data memory contents into <br> `final_mem.hex`.
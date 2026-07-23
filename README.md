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

This compiles the full processor. It runs the current program in `instruction_mem.hex`, it prints a per-cycle trace to the terminal, dumps the waveform to `dump.vcd`, and writes the final data memory contents into `final_mem.hex`.<br>

Verification
===
+ There is a testbench for ALU, Control Unit, Register File, Instruction Memory, Immediate Generator, Programme Counter and Data Memory.<br>
+ The `Top_Module_Tb` testbench works slightly differently, it exersizes the current program stored in `instruction_mem.hex`and stores the final state in `final_mem.hex`. <br>
<br>
Below is the final waveform diagram for the `initial_mem.hex` in this repo.
<br>

![alt text](<Screenshot 2026-07-03 000758.png>)
<br>

Known Limitations (Potential Future Changes)
===
+ Only single-cycle. Pipelining would allow for a higher throughput, its not an issue as this cpu is not on physical hardware, but if it were to be adapted for real hardware piplining is advisable.
+ There currently isnt any CSR support, exeptions or interrupts. CSR is an important addition from a reliability, error handeling and cycber-security standpoint. Exeptions is important for memory protection, illegal instruction detection and system calls. Interrupts is a required additon for multitasking and I/O.
+ There are many more instructions that can be added for example `JALR`, `LUI`, `AUIPC`, remaining branch instructions, ect.
<br>

References
===
Patterson & Hennessy, Computer Organization and Design: The Hardware/ Software Interface (RISC-V Edition) - datapath layout reference (Figure 4.21). <br>
[RISC-V Specifications ISA](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv32.html)
<br>

Thanks for viewing, <br>
Conor McArdle
`timescale 1ns/1ps

module instruction_mem(
    input [31:0] pc,
    output [31:0] instruction);

reg [31:0] mem [0:1023];

assign instruction = mem[pc[11:2]];          //PC loads a 32 bit instruction bits 11:2 represent a location in that memory array.

initial begin
    $readmemh("Instruction_Memory/instruction_mem.hex", mem);
end
endmodule

// Some important stuff to note. This architecture is based of the RV32I ISA reference https://docs.riscv.org/reference/isa/v20260120/unpriv/rv32.html
// for any confusion regarding why selected bits strings are used and where. Additionally instruction_mem.hex is a notepad file that contains all of
// the all hex instructions. This module operates as a reduced version of typical cpu cache and the hex file operates as the data stored in cache.
// This choice was made as it makes it cleaner to update also it allows for easier implementation of a simulated compiler in future which could
// compile basic c to run on this cpu. *Note feel free to move this text to the readme later or into the notebook (cant find notbook rn thats why its here).
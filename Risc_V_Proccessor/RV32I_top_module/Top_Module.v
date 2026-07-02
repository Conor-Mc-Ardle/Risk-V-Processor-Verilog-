`timescale 1ns/1ps

//The layout of this processor is based off Computer Organization and Design: The Hardware/Software Interface (RISC-V Edition) figure 4.21
// When refering to the inspirtaion design remember that in this design alu_control and contol are combined under the one module.
module top_module(
    input clk, reset);

wire alu_immediate, branch, mem_read, mem_write, reg_write, jal;
wire [6:0] opcode, funct7;
wire [2:0] sel, funct3;

//register file
wire [4:0] rs1, rs2, rd;
wire [31:0] write_data, read_data1, read_data2;

//instruction memory
wire [31:0] instruction;
// Mentioned Later: [31:0] pc

//immediate gen
wire [31:0] immediate;
//Already mentioned: [31:0] instructions

// programme counter
wire [31:0] pc, pc_next;
// Already mentioned: reset, clk

//pc +4;
wire [31:0] pc_4;

// Immediate shift
wire [31:0] imm_shift;

// Branch or Jump
wire [31:0] branch_jump;

// wire from and gate to the mux that selects next pc state
wire pc_and_mux;

//Alu
wire zero, negative, carry, overflow;
wire [31:0] b, result;
//Already Mentioned: [2:0] select, reffered to as sel. [31:0] a is reffered to as read_data1

//Data Memory
wire [31:0] read_data;
//Already mentioned: clk, mem_read, mem_write, address is same as result in alu, write_data is same as read_data2

control_unit control_unit (
    .alu_immediate(alu_immediate),
    .branch(branch),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .jal(jal),
    .sel(sel),
    .funct7(funct7),
    .funct3(funct3),
    .opcode(opcode));

register_file register_file (
    .reg_write(reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .clk(clk),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2));

instruction_mem instruction_mem(
    .pc(pc),
    .instruction(instruction));

// following risc v unprivileged isa rv32i 2.1.4.2 integer register-register instructions diagram
assign opcode = instruction[6:0];
assign funct7 = instruction[31:25];
assign funct3 = instruction[14:12];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rd = instruction[11:7];

immediate_gen immediate_gen(
    .immediate(immediate),
    .instruction(instruction));

p_count programme_counter(
    .pc(pc),
    .pc_next(pc_next),
    .reset(reset),
    .clk(clk));

//Pc_Next decision
assign pc_4 = pc + 4;                               // Pc + 4
assign imm_shift = immediate;
assign branch_jump = pc + imm_shift;                //Disregard carry bits
assign pc_and_mux = zero & branch;                  //Alu zero flag & control branch flag, acts as the sel for the pc_next mux
assign pc_next = (jal | pc_and_mux) ? branch_jump : pc_4;    // Mux that decides pc_next

alu alu(
    .select(sel),
    .zero(zero),
    .negative(negative),
    .carry(carry),
    .overflow(overflow),
    .a(read_data1),
    .b(b),
    .result(result));

//Read data2 to alu mux
assign b = alu_immediate ? immediate : read_data2;

data_module data_mem(
    .clk(clk),
    .read_data(read_data),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(result),
    .write_data(read_data2));

assign write_data = jal ? pc_4  : mem_read ? read_data : result;
endmodule

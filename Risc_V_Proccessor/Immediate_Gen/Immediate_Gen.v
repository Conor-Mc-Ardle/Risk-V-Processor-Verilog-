`timescale 1ns/1ps

module immediate_gen(
    input [31:0] instruction,
    output reg [31:0] immediate
);

wire [6:0] opcode;
assign opcode = instruction[6:0];                //opcode used to distinguish between instruction type


localparam ADDI_OP = 7'b0010011;                //Lowkey remembered localparams existed gonna use these now as it makes the code easier to read
localparam LW_OP = 7'b0000011;
localparam SW_OP = 7'b0100011;
localparam BEQ_OP = 7'b1100011;
localparam JAL_OP = 7'b1101111;

always@(*) begin

case (opcode)
ADDI_OP, LW_OP: immediate = {{20{instruction[31]}}, instruction[31:20]};                                               // I type
SW_OP: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};                                     // S type
BEQ_OP: immediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};              // B type
JAL_OP: immediate = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};            // J type
endcase
end
endmodule
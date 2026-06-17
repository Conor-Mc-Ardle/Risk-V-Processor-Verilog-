`timescale 1ns/1ps

module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] select,
    output reg [31:0] result,
    output zero                                             // It seems to be refered to as "zero flag" in most examples
);

always@(*) begin
    case(select)
    3'b000: result = a + b;                                 // Add
    3'b001: result = a - b;                                 // Sub
    3'b010: result = a & b;                                 // And
    3'b011: result = a ^ b;                                 // Or
    3'b100: result = a | b;                                 // Xor
    3'b101: result = a << b[4:0];                           // SLL    (a^b)
    3'b110: result = ($signed(a)) < ($signed(b));           // SLT    $signed used so that negative numbers dont result in errors
    default: result = 32'b0;
    endcase
end

assign zero = (result == 32'b0);                            // Zero Flag



endmodule
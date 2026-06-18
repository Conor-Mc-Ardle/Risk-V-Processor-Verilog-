`timescale 1ns/1ps

module alu_tb;

reg [31:0] a, b;
reg [2:0] sel;
reg [31:0] e_result;
wire [31:0] result;
reg e_zero, e_negative, e_carry, e_overflow;
wire zero, neg, carry, overflow;


alu uut (.a(a), .b(b), .select(sel), .result(result), .zero(zero), .negative(neg), .carry(carry), .overflow(overflow));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);

    // Add tests
    // 5 + 10 = 15
a = 5; b = 10; e_result = 15; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0; sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 7 + (-7) = 0
a = 7; b = -7; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 1; e_overflow = 0;  sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 2147483647 + 1 = -2147483648 (the overflow should flag the false negative)
a = 32'h7FFFFFFF; b = 32'd1; e_result = 32'h80000000; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 1; sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    //-2147483648 + (-2147483648) = 0 (overflow should flag, it appears as zero as -4294967296 is a 33 bit signed integer)
a = 32'h80000000; b = 32'h80000000; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 1; e_overflow = 1;  sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    //4294967295 + 4294967295 = 4294967294 (This is another instance of it carrying to the 33 bit, carry should flag)
a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; e_result = 32'hFFFFFFFE; e_zero = 0; e_negative = 1; e_carry = 1; e_overflow = 0;  sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // Sub tests
    // 15 - 10 = 5
a = 15; b = 10; e_result = 5; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 7 - 7 = 0
a = 7; b = 7; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 5 - 10 = -5
a = 5; b = 10; e_result = -5; e_zero = 0; e_negative = 1; e_carry = 1; e_overflow = 0;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 2147483648 - 1 = 2147483647
a = 32'h80000000; b = 1; e_result = 32'h7FFFFFFF; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 1;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 2147483647 - 2147483648 = -1
a = 32'h7FFFFFFF; b = 32'h80000000; e_result = 32'hFFFFFFFF; e_zero = 0; e_negative = 1; e_carry = 1; e_overflow = 1;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);


    // And tests
    // 010 & 110 = 010
a = 32'b010; b = 32'b110; e_result = 32'b010; sel = 3'b010; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 
$finish;
end
endmodule


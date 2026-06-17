`timescale 1ns/1ps

module alu_tb;

reg [31:0] a, b;
reg [2:0] select;
reg [31:0] expected_result;
wire [31:0] result;

alu uut (.a(a), .b(b), .result(result));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);

    // Add tests

a = 5; b = 10; expected_result = 15; select = 3'd000; #10;
if (result == expected_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, expected_result);


$finish;
end
endmodule


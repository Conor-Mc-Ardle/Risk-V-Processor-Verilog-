`timescale 1ns/1ps

module pc_tb;

reg clk, reset;
reg [31:0] pc_next;
wire [31:0] pc;
reg [31:0] e_pc;

p_count uup (.clk(clk), .reset(reset), .pc_next(pc_next), .pc(pc));

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, pc_tb);
    
    clk = 0;

// Check Reset
reset = 1; pc_next = 32'hFFFFFFFF; e_pc = 32'd0;
@(posedge clk); #1;

if (e_pc == pc)
    $display("Pass");
else
    $display("Fail! Result/Expected - PC:%0d/%0d", pc, e_pc);

// PC update
reset = 0; pc_next = 32'hFFFFFFFF; e_pc = 32'hFFFFFFFF;
@(posedge clk); #1;

if (e_pc == pc)
    $display("Pass");
else
    $display("Fail! Result/Expected - PC:%0d/%0d", pc, e_pc);
$finish;
end
endmodule
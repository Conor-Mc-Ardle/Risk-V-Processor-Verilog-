`timescale 1ns/1ps

module top_module_tb;

reg clk;
reg reset;

top_module uup (.clk(clk), .reset(reset));

initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");

    $dumpvars(0, uup);
 
    reset = 1;
    repeat (2) @(posedge clk);
    reset = 0;

    repeat (60) begin
        @(posedge clk);
        $display("t=%0t pc=%h instr=%h rd=%d rw=%b result=%h", $time, uup.pc, uup.instruction, uup.rd, uup.reg_write, uup.result);
    end

    $writememh("final_mem.hex", uup.data_mem.mem, 0, 255);

    $finish;
end
endmodule
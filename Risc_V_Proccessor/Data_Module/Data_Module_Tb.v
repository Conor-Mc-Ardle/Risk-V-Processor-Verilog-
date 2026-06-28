`timescale 1ns/1ps

module data_module_tb;

reg clk, mem_read, mem_write;
reg [31:0] address, write_data;
wire [31:0] read_data;
reg [31:0] e_read_data;

data_module uup (.clk(clk), .mem_read(mem_read), .mem_write(mem_write), .address(address), .write_data(write_data), .read_data(read_data));

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, data_module_tb);

    clk = 0;

// Initial data memory addresses should be 0
mem_read = 1; mem_write = 0; address = 32'd0; write_data = 32'd0; e_read_data = 32'd0; @(posedge clk); #1;

if (e_read_data == read_data)
    $display("Pass");
else
    $display("Fail! Result/Expected - PC:%0d/%0d", read_data, e_read_data);

end
endmodule
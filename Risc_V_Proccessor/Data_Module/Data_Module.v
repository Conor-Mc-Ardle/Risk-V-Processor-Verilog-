`timescale 1ns/1ps

module data_module(
    input clk, mem_read, mem_write,
    input [31:0] address, write_data,
    output reg [31:0] read_data);

reg [31:0] mem [0:1023];

integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        mem[i] = 32'd0;
    end
end
always@(*) begin
 if(mem_read == 1)
    read_data = mem[address[11:2]];
 else
    read_data = 32'd0;
end

always@(posedge clk) begin
    if(mem_write == 1)
    mem[address[11:2]] <= write_data;
end
endmodule
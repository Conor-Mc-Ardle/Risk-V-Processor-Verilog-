`timescale 1ns/1ps

module register_file_tb;

reg clk;
reg [4:0] rs1, rs2, rd;
reg [31:0] write_data;
reg reg_write;
wire [31:0] read_data1, read_data2;
reg [31:0] e_read_data1, e_read_data2;

always #5 clk = ~clk;

register_file uup ( .clk(clk), .rs1(rs1), .rs2(rs2), .rd(rd), .write_data(write_data), .reg_write(reg_write), .read_data1(read_data1), .read_data2(read_data2));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, register_file_tb);

    clk = 0;

// Write 42 to x1 then read back
rd = 5'd1; write_data = 32'd42; reg_write = 1;
rs1 = 5'd1; rs2 = 5'd0;
@(posedge clk); #1;

if (read_data1 == 32'd42 && read_data2 == 32'd0)
    $display("Pass");
else
    $display("Fail! Result/Expected - Read_Data1:%0d/%0d - Read_Data2:%0d/%0d",
    read_data1, e_read_data1, read_data2, e_read_data2);

// Write 100 to x2 then read back
rd = 5'd2; write_data = 32'd100; reg_write = 1;
rs1 = 5'd0; rs2 = 5'd2;
@(posedge clk); #1;

if (read_data1 == 32'd0 && read_data2 == 32'd100)
    $display("Pass");
else
    $display("Fail! Result/Expected - Read_Data1:%0d/%0d - Read_Data2:%0d/%0d",
    read_data1, e_read_data1, read_data2, e_read_data2);

// Write to x0 then read back, x0 is hardwired to 0 so should remain as 0
rd = 5'd0; write_data = 32'd999; reg_write = 1;
rs1 = 5'd0; rs2 = 5'd0;
@(posedge clk); #1;

if (read_data1 == 32'd0 && read_data2 == 32'd0)
    $display("Pass");
else
    $display("Fail! Result/Expected - Read_Data1:%0d/%0d - Read_Data2:%0d/%0d",
    read_data1, e_read_data1, read_data2, e_read_data2);

// reg_write set to 0 so it shouldnt write. It should maintain its previous value (42) and not the new value 365
rd = 5'd1; write_data = 32'd365; reg_write = 0;
rs1 = 5'd1; rs2 = 5'd0;
@(posedge clk); #1;

if (read_data1 == 32'd42 && read_data2 == 32'd0)
    $display("Pass");
else
    $display("Fail! Result/Expected - Read_Data1:%0d/%0d - Read_Data2:%0d/%0d",
    read_data1, e_read_data1, read_data2, e_read_data2);
$finish;
end
endmodule
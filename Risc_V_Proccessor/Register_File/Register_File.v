`timescale 1ns/1ps

module register_file(
    input clk,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data,
    input reg_write,
    output reg [31:0] read_data1, read_data2
);

reg [31:0] reg_array [31:0];

always@(*) begin
    if ((rs1 & rs2) == 0) begin
        read_data1 = 0;
        read_data2 = 0;
    end
    else begin
    read_data1 = reg_array[rs1];
    read_data2 = reg_array[rs2];
    end
end

always@(posedge clk) begin
    if ((reg_write == 1) & (rd != 5'd0 )) begin     //Rd cant be 0 as that is the location of x0 which should always remain 0, hence dont write to it
        reg_array[rd] <= write_data;
    end
end
endmodule
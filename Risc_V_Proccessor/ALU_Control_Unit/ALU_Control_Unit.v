`timescale 1ns/1ps

module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [2:0] sel,
    output reg alu_immediate, branch, mem_read, mem_write, reg_write, jal
);

always@(*) begin
    alu_immediate = 0;          //Takes the immediate value instead of the x1 (ADDI x1, x2, 6) 6 is the immediate
    branch = 0;                 //This and some other inputs decide changes in pc
    mem_read = 0;               //Next 3 are self explanatory (hopefully i dont regret saying this lol)
    mem_write = 0;
    reg_write = 0;
    jal = 0;                    //Jump and save the return address
    sel = 3'b000;

    casez({opcode, funct3, funct7[5]})
    {7'b0110011, 3'b000, 1'b0}: begin                          //ADD
        sel = 3'b000;
        reg_write = 1;
    end
    {7'b0110011, 3'b000, 1'b1}: begin                          //SUB
        sel = 3'b001;
        reg_write = 1;
    end
    {7'b0110011, 3'b111, 1'bz}: begin                          //AND
        sel = 3'b010;
        reg_write = 1;
    end
    {7'b0110011, 3'b100, 1'bz}: begin                          //XOR
        sel = 3'b100;
        reg_write = 1;
    end
    {7'b0110011, 3'b110, 1'bz}: begin                          //OR
        sel = 3'b011;
        reg_write = 1;
    end
    {7'b0110011, 3'b001, 1'bz}: begin                          //SLL
        sel = 3'b101;
        reg_write = 1;
    end
    {7'b0110011, 3'b010, 1'bz}: begin                          //SLT
        sel = 3'b110;
        reg_write = 1;
    end
    {7'b0010011, 3'b000, 1'bz}: begin                          //ADDI
        sel = 3'b000;
        reg_write = 1;
        alu_immediate = 1;
    end
    {7'b0000011, 3'b010, 1'bz}: begin                          //LW
        sel = 3'b000;
        reg_write = 1;
        alu_immediate = 1;
        mem_read = 1;
    end
    {7'b0100011, 3'b010, 1'bz}: begin                          //SW
        sel = 3'b000;
        alu_immediate = 1;
        mem_write = 1;
    end
    {7'b1100011, 3'b000, 1'bz}: begin                          //BEQ
        sel = 3'b001;
        branch = 1;
    end
    {7'b1101111, 3'bzzz, 1'bz}: begin                          //JAL
        sel = 3'b000;
        reg_write = 1;
        jal = 1;
    end
    endcase

end
endmodule
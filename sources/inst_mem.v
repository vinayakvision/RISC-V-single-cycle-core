module inst_mem (
    input  wire [4:0]  addr,        // instruction index (pc[6:2])
    input  wire         inst_en,
    output wire [31:0]  instruction
);

    reg [31:0] instruction_mem [0:31];

    initial begin
        // ========== R-TYPE ==========
        instruction_mem[0] = 32'b0000000_00010_00001_000_00011_0110011; // add  x3,  x1, x2
        instruction_mem[1] = 32'b0100000_00010_00001_000_00100_0110011; // sub  x4,  x1, x2
        instruction_mem[2] = 32'b0000000_00010_00001_111_00101_0110011; // and  x5,  x1, x2
        instruction_mem[3] = 32'b0000000_00010_00001_110_00110_0110011; // or   x6,  x1, x2
        instruction_mem[4] = 32'b0000000_00010_00001_100_00111_0110011; // xor  x7,  x1, x2
        instruction_mem[5] = 32'b0000000_00010_00001_010_01000_0110011; // slt  x8,  x1, x2

        // ========== ADDI ==========
        instruction_mem[6] = 32'b000000000010_00001_000_01001_0010011; // addi x9,  x1, 2

        // ========== LW ==========
        instruction_mem[7] = 32'b000000000100_00001_010_01010_0000011; // lw   x10, 4(x1)

        // ========== SW ==========
        
instruction_mem[8] = 32'b0000000_01010_00001_010_10000_0100011; // sw x10, 16(x1)


        // ========== NOPs ==========
        instruction_mem[9]  = 32'h00000013;
        instruction_mem[10] = 32'h00000013;
        instruction_mem[11] = 32'h00000013;
        instruction_mem[12] = 32'h00000013;
        instruction_mem[13] = 32'h00000013;
        instruction_mem[14] = 32'h00000013;
        instruction_mem[15] = 32'h00000013;
    end

    assign instruction = inst_en ? instruction_mem[addr] : 32'b0;

endmodule


module control (
    input  wire [31:0] instruction,

    output reg         write_en,
    output reg [4:0]   opcode_alu,
    output reg         imm_valid,
    output reg         mem_read,
    output reg         mem_write,
    output reg         mem_to_reg
);

always @(*) begin
    // defaults
    write_en   = 0;
    opcode_alu = 5'b00000;
    imm_valid  = 0;
    mem_read   = 0;
    mem_write  = 0;
    mem_to_reg = 0;

    case (instruction[6:0])

        // ================= R-TYPE =================
        7'b0110011: begin
            write_en  = 1;
            imm_valid = 0;

            case ({instruction[31:25], instruction[14:12]})
                10'b0000000_000: opcode_alu = 5'b00001; // ADD
                10'b0100000_000: opcode_alu = 5'b00010; // SUB
                10'b0000000_111: opcode_alu = 5'b00101; // AND
                10'b0000000_110: opcode_alu = 5'b00100; // OR
                10'b0000000_100: opcode_alu = 5'b00011; // XOR
                10'b0000000_010: opcode_alu = 5'b01001; // SLT
            endcase
        end

        // ================= ADDI =================
        7'b0010011: begin
            write_en  = 1;
            imm_valid = 1;

            case (instruction[14:12])
                3'b000: opcode_alu = 5'b00001; // ADDI
                3'b010: opcode_alu = 5'b01001; // SLTI
            endcase
        end

        // ================= LW =================
        7'b0000011: begin
            write_en   = 1;
            imm_valid  = 1;
            mem_read   = 1;
            mem_to_reg = 1;
            opcode_alu = 5'b00001; // ADD (address)
        end

        // ================= SW =================
        7'b0100011: begin
            imm_valid  = 1;
            mem_write  = 1;
            opcode_alu = 5'b00001; // ADD (address)
        end

    endcase
end

endmodule


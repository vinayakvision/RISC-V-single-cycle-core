module top (
    input wire clk,
    input wire reset
);

    // -------------------------
    // PC & Instruction
    // -------------------------
    wire [4:0]  pc_out;
    wire [31:0] instruction;

    // -------------------------
    // Decode
    // -------------------------
    wire [4:0]  rs1_addr, rs2_addr, rd_addr;
    wire [11:0] imm_value;

    // -------------------------
    // Control
    // -------------------------
    wire        write_en;
    wire        imm_valid;
    wire        mem_read;
    wire        mem_write;
    wire        mem_to_reg;
    wire [4:0]  opcode_alu;

    // -------------------------
    // Datapath
    // -------------------------
    wire [31:0] rs1_data, rs2_data;
    wire [31:0] imm_ext;
    wire [31:0] alu_b;
    wire [31:0] alu_result;
    wire [31:0] mem_data;
    wire [31:0] wb_data;

    // =========================
    // PROGRAM COUNTER
    // =========================
    program_counter PC (
        .clk   (clk),
        .reset (reset),
        .en    (1'b1),
        .pc_out(pc_out)
    );

    // =========================
    // INSTRUCTION MEMORY
    // =========================
    inst_mem IMEM (
        .addr(pc_out),
        .inst_en(1'b1),
        .instruction(instruction)
    );

    // =========================
    // DECODER
    // =========================
    decoder DEC (
        .instruction(instruction),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr (rd_addr),
        .imm_value(imm_value)
    );

    // =========================
    // CONTROLLER (SINGLE)
    // =========================
    control CTRL (
        .instruction(instruction),
        .write_en   (write_en),
        .opcode_alu (opcode_alu),
        .imm_valid  (imm_valid),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .mem_to_reg (mem_to_reg)
    );

    // =========================
    // REGISTER FILE
    // =========================
    gpr RF (
        .clk(clk),
        .reset(reset),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr (rd_addr),
        .write_en(write_en),
        .write_data(wb_data),
        .rs1_data_out(rs1_data),
        .rs2_data_out(rs2_data)
    );

    // =========================
    // IMMEDIATE GENERATOR
    // =========================
    imm_gen IMM (
        .imm_in (imm_value),
        .imm_out(imm_ext)
    );

    // =========================
    // ALU OPERAND MUX
    // =========================
    alu_operand_mux MUX_B (
        .rs2_data(rs2_data),
        .imm_ext (imm_ext),
        .imm_valid(imm_valid),
        .op_b(alu_b)
    );

    // =========================
    // ALU
    // =========================
    alu ALU (
        .A(rs1_data),
        .B(alu_b),
        .opcode_alu(opcode_alu),
        .result(alu_result)
    );

    // =========================
    // DATA MEMORY
    // =========================
    data_mem DMEM (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(rs2_data),
        .read_data(mem_data)
    );

    // =========================
    // WRITE BACK MUX
    // =========================
    wb_mux WB (
        .alu_result(alu_result),
        .mem_data(mem_data),
        .mem_to_reg(mem_to_reg),
        .wb_data(wb_data)
    );

    // =========================
    // DEBUG (OPTIONAL)
    // =========================
    always @(posedge clk) begin
        $display(
            "PC=%0d | rs1=x%0d(%0d) rs2=x%0d(%0d) rd=x%0d | ALU=%0d | WB=%0d | WE=%b",
            pc_out,
            rs1_addr, rs1_data,
            rs2_addr, rs2_data,
            rd_addr,
            alu_result,
            wb_data,
            write_en
        );
    end

endmodule


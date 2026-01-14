module alu_operand_mux (
    input  wire [31:0] rs2_data,
    input  wire [31:0] imm_ext,
    input  wire        imm_valid,
    output wire [31:0] op_b
);

assign op_b = imm_valid ? imm_ext : rs2_data;

endmodule


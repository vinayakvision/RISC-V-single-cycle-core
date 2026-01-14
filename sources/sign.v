module imm_gen (
    input  wire [11:0] imm_in,
    output wire [31:0] imm_out
);

assign imm_out = {{20{imm_in[11]}}, imm_in};

endmodule


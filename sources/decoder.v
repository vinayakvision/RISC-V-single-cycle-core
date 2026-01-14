module decoder (
    input  wire [31:0] instruction,
    output reg  [4:0]  rs1_addr,
    output reg  [4:0]  rs2_addr,
    output reg  [4:0]  rd_addr,
    output reg  [11:0] imm_value
);

always @(*) begin
    rs1_addr  = 0;
    rs2_addr  = 0;
    rd_addr   = 0;
    imm_value = 0;

    case (instruction[6:0])

        // R-type
        7'b0110011: begin
            rs1_addr = instruction[19:15];
            rs2_addr = instruction[24:20];
            rd_addr  = instruction[11:7];
        end

        // ADDI, LW
        7'b0010011,
        7'b0000011: begin
            rs1_addr  = instruction[19:15];
            rd_addr   = instruction[11:7];
            imm_value = instruction[31:20];
        end

        // SW
        7'b0100011: begin
            rs1_addr  = instruction[19:15];
            rs2_addr  = instruction[24:20];
            imm_value = {instruction[31:25], instruction[11:7]};
        end

    endcase
end

endmodule


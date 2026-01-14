module gpr (
    input  wire        clk,
    input  wire        reset,
    input  wire [4:0]  rs1_addr,
    input  wire [4:0]  rs2_addr,
    input  wire [4:0]  rd_addr,
    input  wire        write_en,
    input  wire [31:0] write_data,
    output wire [31:0] rs1_data_out,
    output wire [31:0] rs2_data_out
);

    reg [31:0] regfile [0:31];

    // Simulation initialization
    initial begin
        $readmemh("gpr.hex", regfile);
        regfile[0] = 32'b0;
    end

    // WRITE (synchronous)
    always @(posedge clk) begin
        if (reset)
            regfile[0] <= 32'b0;
        else if (write_en && rd_addr != 5'd0)
            regfile[rd_addr] <= write_data;
    end

    // READ (combinational)
    assign rs1_data_out = (rs1_addr == 0) ? 32'b0 : regfile[rs1_addr];
    assign rs2_data_out = (rs2_addr == 0) ? 32'b0 : regfile[rs2_addr];

    // Optional dump (simulation only)
    initial begin
        #100;
        $writememh("gpr.hex", regfile);
    end

endmodule


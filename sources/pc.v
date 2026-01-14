module program_counter (
    input  wire        clk,
    input  wire        reset,
    input  wire        en,
    output wire [4:0]  pc_out
);

    reg [31:0] pc;

    always @(posedge clk) begin
        if (reset)
            pc <= 32'd0;
        else if (en)
            pc <= pc + 32'd4;
    end

    assign pc_out = pc[6:2];  // instruction index

endmodule


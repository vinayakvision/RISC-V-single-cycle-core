module data_mem (
    input  wire        clk,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] addr,        // byte address from ALU
    input  wire [31:0] write_data,  // rs2 value
    output wire [31:0] read_data
);

    reg [31:0] mem [0:255];

    // Simulation initialization
    initial begin
        $readmemh("data_mem.hex", mem);
    end

    // READ (lw)
    assign read_data = mem_read ? mem[addr[9:2]] : 32'b0;

    // WRITE (sw)
    always @(posedge clk) begin
        if (mem_write)
            mem[addr[9:2]] <= write_data;
    end

    // Optional dump
    initial begin
        #100;
        $writememh("data_mem.hex", mem);
    end

endmodule


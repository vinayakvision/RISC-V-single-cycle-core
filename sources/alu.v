module alu (
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [4:0]  opcode_alu,
    output reg  [31:0] result
);

always @(*) begin
    case (opcode_alu)
        5'b00001: result = A + B;                       // ADD
        5'b00010: result = A - B;                       // SUB
        5'b00011: result = A ^ B;                       // XOR
        5'b00100: result = A | B;                       // OR
        5'b00101: result = A & B;                       // AND
        5'b01001: result = ($signed(A) < $signed(B));   // SLT
        default:  result = 0;
    endcase
end

endmodule


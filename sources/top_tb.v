module top_tb;

    reg clk;
    reg reset;

    // DUT
    top dut (
        .clk(clk),
        .reset(reset)
    );

    // CLOCK: 10ns period
    always #5 clk = ~clk;

    initial begin
        // INIT
        clk   = 0;
        reset = 1;

        // Apply reset
        #10;
        reset = 0;

        // Run simulation
        #200;

        $display("Simulation finished.");
//$display("FINAL DMEM CHECK: mem[2] = %0d", dut.DMEM.mem[2]);


        $stop;
    end
initial begin
$shm_open("wave.shm");
$shm_probe("ACTMF");
end

endmodule


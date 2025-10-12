//==============================================
// Self-Checking Testbench for Parity Generator
//==============================================
`timescale 1ns/1ps

module tb_parity_generator;

    reg  [7:0] data_in;
    wire parity_bit;

    // Instantiate DUT
    parity_generator dut (
        .data_in(data_in),
        .parity_bit(parity_bit)
    );

    // Expected parity bit calculated in TB
    reg expected_parity;
    integer i, error_count = 0;

    initial begin
        $display("Starting Parity Generator Testbench...");
        $display("=====================================");
        $display("  Data In      DUT Parity  Expected  Result");
        $display("=====================================");

        // Apply multiple random test vectors
        for (i = 0; i < 20; i = i + 1) begin
            data_in = $random;                // Random 8-bit data
            expected_parity = ^data_in;       // Expected even parity

            #1; // Small delay for DUT to compute

            if (parity_bit === expected_parity)
                $display("%b       %b          %b        PASS", data_in, parity_bit, expected_parity);
            else begin
                $display("%b       %b          %b        FAIL", data_in, parity_bit, expected_parity);
                error_count = error_count + 1;
            end
        end

        $display("=====================================");
        if (error_count == 0)
            $display("✅ All tests PASSED!");
        else
            $display("❌ %0d tests FAILED!", error_count);

        $finish;
    end

endmodule

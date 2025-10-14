//==========================================================
//  Testbench Name : tb_parity_checker
//  Function       : Self-checking testbench for parity checker
//==========================================================
module tb_parity_checker;

    parameter WIDTH = 8;
    reg  [WIDTH-1:0] data_in;
    reg               parity_bit;
    wire              error_flag;

    integer i;
    integer error_count = 0;

    // DUT instantiation
    parity_checker #(WIDTH) dut (
        .data_in(data_in),
        .parity_bit(parity_bit),
        .error_flag(error_flag)
    );

    // Self-checking logic
    initial begin
        $display("=== Starting Parity Checker Test ===");

        // Test multiple random vectors
        for (i = 0; i < 20; i = i + 1) begin
            data_in = $random;
            
            // Generate correct even parity
            parity_bit = ^data_in;

            #1; // wait for combinational logic
            if (error_flag !== 0) begin
                $display("[ERROR] Incorrect parity detected for data=%b", data_in);
                error_count = error_count + 1;
            end

            // Introduce an error intentionally
            parity_bit = ~(^data_in);

            #1;
            if (error_flag !== 1) begin
                $display("[ERROR] Failed to detect wrong parity for data=%b", data_in);
                error_count = error_count + 1;
            end
        end

        // Final check
        if (error_count == 0)
            $display("✅ All test cases passed successfully!");
        else
            $display("❌ %0d test(s) failed.", error_count);

        $finish;
    end

endmodule

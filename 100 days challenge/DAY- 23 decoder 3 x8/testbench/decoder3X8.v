`timescale 1ns/1ps

module tb_decoder3x8;

    reg  [2:0] din;
    reg        en;
    wire [7:0] dout;

    // Instantiate DUT
    decoder3x8 dut (
        .din(din),
        .en(en),
        .dout(dout)
    );

    integer i;
    reg [7:0] expected; // expected output

    initial begin
        $display("Starting Testbench for 3x8 Decoder...");
        en = 0;
        din = 3'b000;

        // Check when enable = 0
        #5;
        if (dout !== 8'b00000000)
            $display("ERROR: Enable=0, Expected=00000000, Got=%b", dout);
        else
            $display("PASS: Enable=0, Output Correct (%b)", dout);

        // Enable the decoder
        en = 1;

        // Test all input combinations
        for (i = 0; i < 8; i = i + 1) begin
            din = i[2:0];
            expected = 8'b00000001 << i;
            #5; // wait for propagation

            if (dout !== expected)
                $display("ERROR: Input=%b Expected=%b Got=%b", din, expected, dout);
            else
                $display("PASS: Input=%b Output=%b", din, dout);
        end

        // Final test summary
        $display("All test cases completed!");
        $finish;
    end

endmodule

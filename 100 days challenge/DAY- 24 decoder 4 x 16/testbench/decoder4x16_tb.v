//-------------------------------------------------------------
// SELF-CHECKING TESTBENCH FOR 4x16 DECODER
//-------------------------------------------------------------
module tb_decoder_4x16();

reg  [3:0] in;
wire [15:0] out;
reg  [15:0] expected;

// Instantiate DUT
decoder_4x16 dut (
    .in(in),
    .out(out)
);

// Test logic
integer i;
initial begin
    $display("Starting 4x16 Decoder Test...");
    $display("Time\tInput\t\tOutput\t\tExpected\tResult");

    for (i = 0; i < 16; i = i + 1) begin
        in = i;                    // apply input
        expected = 16'b0;
        expected[i] = 1'b1;        // expected output
        #1;                        // wait for output to settle

        if (out === expected)
            $display("%0t\t%b\t%b\t%b\tPASS", $time, in, out, expected);
        else
            $display("%0t\t%b\t%b\t%b\tFAIL", $time, in, out, expected);
    end

    $display("All test cases completed.");
    $finish;
end

endmodule

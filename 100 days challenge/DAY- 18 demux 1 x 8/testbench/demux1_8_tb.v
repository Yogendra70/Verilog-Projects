
`timescale 1ns/1ps

module tb_demux_1x8;

    reg din;
    reg [2:0] sel;
    wire [7:0] y;

    integer i;  // loop variable
    reg [7:0] expected;

    // Instantiate the DUT (Device Under Test)
    demux_1x8 uut (
        .din(din),
        .sel(sel),
        .y(y)
    );

    initial begin
        $display("==============================================");
        $display("Starting 1x8 DEMUX Self-Checking Testbench...");
        $display("==============================================");

        // Test all select combinations with both din = 0 and din = 1
        for (i = 0; i < 8; i = i + 1) begin
            sel = i[2:0];
            din = 1'b0;
            #5;
            expected = (din) ? (8'b1 << sel) : 8'b0;
            if (y !== expected)
                $display("FAIL: sel=%b din=%b => y=%b (expected %b)", sel, din, y, expected);
            else
                $display("PASS: sel=%b din=%b => y=%b", sel, din, y);

            din = 1'b1;
            #5;
            expected = (din) ? (8'b1 << sel) : 8'b0;
            if (y !== expected)
                $display("FAIL: sel=%b din=%b => y=%b (expected %b)", sel, din, y, expected);
            else
                $display("PASS: sel=%b din=%b => y=%b", sel, din, y);
        end

        $display("==============================================");
        $display("Simulation Completed!");
        $display("==============================================");
        $finish;
    end

endmodule

`timescale 1ns/1ps
module xnor_gate_tb;

    reg a;
    reg b;
    wire y;
    integer errors;

    // DUT instantiation
    xnor_gate dut (
        .a(a),
        .b(b),
        .y(y)
    );

    // Dumpfile for waveform
    initial begin 
        $dumpfile("xnor_gate_tb.vcd");
        $dumpvars(0, xnor_gate_tb);
    end

    // Self-checking task
    task check_xnor(input reg t_a, input reg t_b);
        reg expected;
    begin 
        a = t_a;
        b = t_b;
        expected = ~(t_a ^ t_b);
        #1; // wait for output to settle
        if (y !== expected) begin
            $display("FAILED: Time=%0t | a=%b b=%b | y=%b (expected=%b)",
                      $time, a, b, y, expected);
            errors = errors + 1;
        end else begin
            $display("PASSED: Time=%0t | a=%b b=%b | y=%b",
                      $time, a, b, y);
        end
    end
    endtask

    // Test all cases
    initial begin 
        errors = 0;

        check_xnor(0,0);
        check_xnor(0,1);
        check_xnor(1,0);
        check_xnor(1,1);

        if (errors == 0)
            $display("\nALL TESTS PASSED ✅");
        else 
            $display("\n%0d TEST(S) FAILED ❌", errors);

        #5 $finish;
    end

endmodule

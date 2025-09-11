`timescale 1ns/1ps
module half_adder_tb;

    reg a;
    reg b;
    wire sum;
    wire carry;
    integer errors;

    // DUT instantiation
    half_adder dut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    // Dumpfile for waveform
    initial begin 
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0, half_adder_tb);
    end

    // Self-checking task
    task check(input reg t_a, input reg t_b);
        reg expected_sum;
        reg expected_carry;
    begin
        a = t_a;
        b = t_b;
        expected_sum   = t_a ^ t_b;
        expected_carry = t_a & t_b;
        #1; // allow signals to settle

        if ((sum !== expected_sum) || (carry !== expected_carry)) begin
            $display("FAILED: Time=%0t | a=%b b=%b | sum=%b carry=%b (expected_sum=%b expected_carry=%b)", 
                      $time, a, b, sum, carry, expected_sum, expected_carry);
            errors = errors + 1;   // <-- FIX: increment error counter
        end else begin 
            $display("PASSED: Time=%0t | a=%b b=%b | sum=%b carry=%b", 
                      $time, a, b, sum, carry);
        end
    end
    endtask 

    // Stimulus
    initial begin 
        errors = 0;

        check(0,0);
        check(0,1);
        check(1,0);
        check(1,1);

        if (errors == 0) 
            $display("\nALL TESTS PASSED ✅");
        else
            $display("\n%0d TEST(S) FAILED ❌", errors);

        #5 $finish;
    end

endmodule

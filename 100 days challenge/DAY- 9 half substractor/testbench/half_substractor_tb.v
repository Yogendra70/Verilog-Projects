`timescale 1ns/1ps
module half_substractor_tb;

    reg a;
    reg b;
    wire difference;
    wire borrow;
    integer errors;

    // DUT instantiation
    half_substractor dut (
        .a(a),
        .b(b),
        .difference(difference),
        .borrow(borrow)
    );

    // Dumpfile
    initial begin 
        $dumpfile("half_substractor_tb.vcd");
        $dumpvars(0, half_substractor_tb);
    end

    // Self-checking task
    task check_input(input reg t_a, input reg t_b);
        reg expected_difference;
        reg expected_borrow;
    begin
        a = t_a;
        b = t_b;

        expected_difference = t_a ^ t_b;
        expected_borrow     = (~t_a) & t_b;

        #1; // allow signals to settle

        if ((difference !== expected_difference) || (borrow !== expected_borrow)) begin
            $display("FAILED: Time=%0t | a=%b b=%b | difference=%b borrow=%b (expected_difference=%b expected_borrow=%b)", 
                      $time, a, b, difference, borrow, expected_difference, expected_borrow);
            errors = errors + 1;   // <-- FIX
        end else begin
            $display("PASSED: Time=%0t | a=%b b=%b | difference=%b borrow=%b", 
                      $time, a, b, difference, borrow);
        end
    end
    endtask

    // Stimulus
    initial begin 
        errors = 0;

        check_input(0,0);
        check_input(0,1);
        check_input(1,0);
        check_input(1,1);

        if (errors == 0)
            $display("\nALL TESTS PASSED ✅");
        else
            $display("\n%0d TEST(S) FAILED ❌", errors);

        #5 $finish;
    end

endmodule

module mux2_1_tb();
    reg a;
    reg b;
    reg sel;
    wire y;
    integer errors;

    // Instantiate the DUT (Device Under Test)
    mux2_1 dut(
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $dumpfile("mux2_1_tb.vcd");
        $dumpvars(0, mux2_1_tb);
    end

    // Task to check inputs and expected output
    task check_input(input reg t_a, input reg t_b, input reg t_sel);
        reg expected_y;
        begin
            a = t_a;
            b = t_b;
            sel = t_sel;
            #1;  // Wait for output to settle

            expected_y = (t_sel) ? t_b : t_a;

            if (y !== expected_y) begin
                $display("FAILED: Time=%0t | a=%b b=%b sel=%b | y=%b expected=%b", 
                         $time, a, b, sel, y, expected_y);
                errors = errors + 1;
            end else begin
                $display("PASSED: Time=%0t | a=%b b=%b sel=%b | y=%b", 
                         $time, a, b, sel, y);
            end
        end
    endtask

    initial begin
        errors = 0;

        // Test all input combinations
        check_input(0, 0, 0);
        check_input(0, 0, 1);
        check_input(0, 1, 0);
        check_input(0, 1, 1);
        check_input(1, 0, 0);
        check_input(1, 0, 1);
        check_input(1, 1, 0);
        check_input(1, 1, 1);

        if (errors == 0) begin
            $display("\nALL TESTS PASSED.");
        end else begin
            $display("\n%d TEST(S) FAILED.", errors);
        end

        #10 $finish;
    end

endmodule

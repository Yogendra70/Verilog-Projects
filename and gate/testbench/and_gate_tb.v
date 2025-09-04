`timescale 1ns/1ps
module and_gate_tb;
    reg a, b;
    wire out;

    // Instantiate the AND gate module
    and_gate dut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        $monitor("Time=%0t | a=%b b=%b | out=%b", $time, a, b, out);

        a = 0; b = 0; #10;
        check_output(a, b, out);

        a = 0; b = 1; #10;
        check_output(a, b, out);

        a = 1; b = 0; #10;
        check_output(a, b, out);

        a = 1; b = 1; #10;
        check_output(a, b, out);

        $display("All tests completed");
        $finish;
    end

    // Task to check output correctness
    task check_output(input reg a_val, input reg b_val, input wire out_val);
    begin
        if (out_val !== (a_val & b_val)) begin
            $display("ERROR: At time %0t, inputs a=%b, b=%b, expected out=%b but got out=%b", 
                      $time, a_val, b_val, (a_val & b_val), out_val);
        end
    end
    endtask

endmodule

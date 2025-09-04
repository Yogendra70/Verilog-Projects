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
        // Dumpfile and dumpvars for waveform generation
        $dumpfile("and_gate_tb.vcd");   // Name of the VCD file
        $dumpvars(0, and_gate_tb);      // Dump all variables in this module and below

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
    task check_output(input a_val, input b_val, input out_val);
    begin
        if (out_val !== (a_val & b_val)) begin
            $display("ERROR: At time %0t, inputs a=%b, b=%b, expected out=%b but got out=%b", 
                      $time, a_val, b_val, (a_val & b_val), out_val);
        end
    end
    endtask

endmodule


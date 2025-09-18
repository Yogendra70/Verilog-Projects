`timescale 1ns/1ps
module tb_n_1_mux;

parameter N = 4;
parameter WIDTH = 4;

reg  [N*WIDTH-1:0] data;
reg  [$clog2(N)-1:0] sel;
wire [WIDTH-1:0] out;

n_1_mux #(N, WIDTH) uut (
    .data(data),
    .sel(sel),
    .out(out)
);

// Task to compute expected output
function [WIDTH-1:0] expected_output;
    input [N*WIDTH-1:0] data_in;
    input [$clog2(N)-1:0] sel_in;
    begin
        expected_output = data_in[sel_in*WIDTH +: WIDTH];
    end
endfunction

integer i, errors;

initial begin
    errors = 0;
    // Random testing loop
    for (i = 0; i < 20; i = i + 1) begin
        // Generate random inputs
        data = {$random, $random, $random, $random} & {{N*WIDTH{1'b1}}};
        sel = $random % N;

        #10;  // Wait for output to settle

        // Check output
        if (out !== expected_output(data, sel)) begin
            $display("ERROR: Test %0d failed for sel=%0d, expected=%h, got=%h", i, sel, expected_output(data, sel), out);
            errors = errors + 1;
        end else begin
            $display("PASS: Test %0d OK for sel=%0d, output=%h", i, sel, out);
        end
    end

    if (errors == 0)
        $display("All tests passed.");
    else
        $display("Total errors: %0d", errors);

    $finish;
end

endmodule

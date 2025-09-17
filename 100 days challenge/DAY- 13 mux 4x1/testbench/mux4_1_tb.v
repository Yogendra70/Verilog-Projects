module tb_mux4to1;

reg  [3:0] d;
reg  [1:0] sel;
wire       y;

mux4to1 uut (
    .d(d),
    .sel(sel),
    .y(y)
);

reg expected;
integer i;
integer error_count = 0;

// Task to calculate expected output
task calc_expected;
    input [3:0] d_in;
    input [1:0] sel_in;
    output      exp_out;
    begin
        case(sel_in)
            2'b00: exp_out = d_in[0];
            2'b01: exp_out = d_in[1];
            2'b10: exp_out = d_in[2];
            2'b11: exp_out = d_in[3];
            default: exp_out = 1'bx;
        endcase
    end
endtask

initial begin
    // Initialize inputs
    d = 4'b0000;
    sel = 2'b00;

    // Test all combinations
    for(i = 0; i < 16; i = i + 1) begin
        d = i; // vary data inputs from 0 to 15

        // Test all select values for each data input
        for(sel = 0; sel < 4; sel = sel + 1) begin
            #10; // wait for output to settle

            calc_expected(d, sel, expected);

            if (y !== expected) begin
                $display("Error #%0d: Test FAILED for d=%b sel=%b expected=%b got=%b", error_count+1, d, sel, expected, y);
                error_count = error_count + 1;
            end else begin
                $display("Test PASSED: d=%b sel=%b output=%b", d, sel, y);
            end
        end
    end

    $display("Testing completed with %0d errors found.", error_count);
    $stop;
end

endmodule

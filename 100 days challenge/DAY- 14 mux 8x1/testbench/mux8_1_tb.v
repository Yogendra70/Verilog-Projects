module tb_mux8to1();

reg [7:0] data;
reg [2:0] sel;
wire out;

mux8to1 uut (
    .data(data),
    .sel(sel),
    .out(out)
);

integer i;
integer error_count;

initial begin
    data = 8'b10101010; // Test pattern
    error_count = 0;

    for (i = 0; i < 8; i = i + 1) begin
        sel = i;
        #10; // wait for output to settle
        
        if (out !== data[i]) begin
            $display("ERROR: sel=%b, expected %b, got %b", sel, data[i], out);
            error_count = error_count + 1;
        end
        else begin
            $display("PASS: sel=%b, output=%b", sel, out);
        end
    end
    
    if (error_count == 0) begin
        $display("All tests passed successfully!");
    end
    else begin
        $display("Testing completed with %d errors.", error_count);
    end

    $finish;
end

endmodule

module n_1_mux #(
    parameter N = 4,               // Number of inputs
    parameter WIDTH = 1            // Width of each input
) (
    input  wire [N*WIDTH-1:0] data,  // Concatenated inputs (N inputs each WIDTH-bit)
    input  wire [$clog2(N)-1:0] sel, // Select signal
    output reg  [WIDTH-1:0] out       // Output
);

integer i;
always @(*) begin
    out = {WIDTH{1'b0}};  // Default value
    for (i = 0; i < N; i = i + 1) begin
        if (sel == i)
            out = data[i*WIDTH +: WIDTH];
    end
end
endmodule

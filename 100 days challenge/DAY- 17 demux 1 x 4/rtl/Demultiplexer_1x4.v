// 1x4 Demultiplexer RTL
module demux_1x4 (
    input wire din,             // Input data
    input wire [1:0] sel,       // 2-bit select line
    output reg [3:0] y          // 4 outputs
);

always @(*) begin
    // Default all outputs to 0
    y = 4'b0000;

    // Route input to selected output
    case (sel)
        2'b00: y[0] = din;
        2'b01: y[1] = din;
        2'b10: y[2] = din;
        2'b11: y[3] = din;
        default: y = 4'b0000;
    endcase
end

endmodule

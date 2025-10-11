
module demux_1x8 (
    input       din,           // Single data input
    input [2:0] sel,           // 3-bit select input
    output reg [7:0] y         // 8 outputs
);

    always @(*) begin
        // Default all outputs to 0
        y = 8'b0000_0000;

        // Enable one output based on select line
        case (sel)
            3'b000: y[0] = din;
            3'b001: y[1] = din;
            3'b010: y[2] = din;
            3'b011: y[3] = din;
            3'b100: y[4] = din;
            3'b101: y[5] = din;
            3'b110: y[6] = din;
            3'b111: y[7] = din;
            default: y = 8'b0000_0000;
        endcase
    end
endmodule

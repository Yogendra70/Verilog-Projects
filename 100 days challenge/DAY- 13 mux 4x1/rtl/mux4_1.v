
module mux4to1 (
    input  wire [3:0] d,   // 4 input data lines
    input  wire [1:0] sel, // 2-bit select line
    output reg        y    // output
);

always @(*) begin
    case (sel)
        2'b00: y = d[0];
        2'b01: y = d[1];
        2'b10: y = d[2];
        2'b11: y = d[3];
        default: y = 1'bx;
    endcase
end

endmodule

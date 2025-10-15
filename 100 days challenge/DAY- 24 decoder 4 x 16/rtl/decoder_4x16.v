//-------------------------------------------------------------
// 4x16 DECODER RTL
//-------------------------------------------------------------
module decoder_4x16 (
    input  [3:0] in,
    output reg [15:0] out
);

always @(*) begin
    out = 16'b0;          // default all zeros
    out[in] = 1'b1;       // set only one bit HIGH based on input
end

endmodule

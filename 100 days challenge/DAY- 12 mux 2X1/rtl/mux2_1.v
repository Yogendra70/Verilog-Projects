module mux2_1(
input sel,
input a,
input b,
output y
);

assign y = sel ? b:a;

endmodule
// File: tb_demux_1x2.v
`timescale 1ns/1ps

module tb_demux_1x2;

    reg din, sel;
    wire y0, y1;

    // DUT instantiation
    demux_1x2 uut (
        .din(din),
        .sel(sel),
        .y0(y0),
        .y1(y1)
    );

    // Self-checking logic
    initial begin
        $display("Time\tSel\tDin\tY0\tY1\tResult");
        $display("-------------------------------------------");

        // Test 1: sel=0, din=1
        sel = 0; din = 1; #5;
        if (y0==1 && y1==0)
            $display("%0t\t%b\t%b\t%b\t%b\tPASS",$time,sel,din,y0,y1);
        else
            $display("%0t\t%b\t%b\t%b\t%b\tFAIL",$time,sel,din,y0,y1);

        // Test 2: sel=1, din=1
        sel = 1; din = 1; #5;
        if (y0==0 && y1==1)
            $display("%0t\t%b\t%b\t%b\t%b\tPASS",$time,sel,din,y0,y1);
        else
            $display("%0t\t%b\t%b\t%b\t%b\tFAIL",$time,sel,din,y0,y1);

        // Test 3: sel=0, din=0
        sel = 0; din = 0; #5;
        if (y0==0 && y1==0)
            $display("%0t\t%b\t%b\t%b\t%b\tPASS",$time,sel,din,y0,y1);
        else
            $display("%0t\t%b\t%b\t%b\t%b\tFAIL",$time,sel,din,y0,y1);

        // Test 4: sel=1, din=0
        sel = 1; din = 0; #5;
        if (y0==0 && y1==0)
            $display("%0t\t%b\t%b\t%b\t%b\tPASS",$time,sel,din,y0,y1);
        else
            $display("%0t\t%b\t%b\t%b\t%b\tFAIL",$time,sel,din,y0,y1);

        $display("-------------------------------------------");
        $display("Simulation completed!");
        $finish;
    end

endmodule

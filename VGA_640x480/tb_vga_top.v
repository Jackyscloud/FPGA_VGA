`timescale 1ns/1ps
module tb_vga_top();
//input
reg clr;
reg clk;
//output
wire hsyncout, vsyncout;
wire [2:0] redout;
wire [2:0] greenout;
wire [1:0] blueout;

//uut
vga_stripes_top uut(
    .btn(clr),
    .clk25(clk),
    .hsync(hsyncout),
    .vsync(vsyncout),
    .red(redout),
    .green(greenout),
    .blue(blueout)
);

initial begin
    clr = 0;
    clk = 1'b1;
end

always #20 clk = ~clk; //25MHz

endmodule

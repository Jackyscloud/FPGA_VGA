`timescale 1ns/1ps
module tb_vga_top();

reg clr;
reg clk25;
wire hsync, vsync;
wire [2:0] red, green;
wire [1:0] blue;

//uut
vga_stripes_top test(
    .btn(clr),
    .clk25(clk25),
    .hsync(hsync),
    .vsync(vsync),
    ,red(red),
    .green(green),
    .blue(blue)
);

initial begin
    clr = 0;
    clk25 = 1'b1;
end

always #20 clk = ~clk; //25MHz

endmodule

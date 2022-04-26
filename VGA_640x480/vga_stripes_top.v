//Example vga_stripes_top
`timescale 1ns/1ps //one finish cycle set 18000ms

module vga_stripes_top();

reg btn;
reg clk25;
wire hsync;
wire vsync;
wire [2:0] red; 
wire [2:0] green;
wire [1:0] blue;

wire clr;
wire vidon;
wire [9:0] hc, vc;

assign clr = btn;

vga_640x480 U1 (
    .clk(clk25), .clr(clr), .hsync(hsync), .vsync(vsync), .hc(hc), .vc(vc), .vidon(vidon)
);

vga_stripes U2 (
    .vidon(vidon), .hc(hc), .vc(vc), .red(red), .green(green), .blue(blue)
);


initial begin
    btn = 1;
    clk25 = 1'b1;
    #40 btn = 0;
end



always #20 clk25 = ~clk25; //25MHz


endmodule

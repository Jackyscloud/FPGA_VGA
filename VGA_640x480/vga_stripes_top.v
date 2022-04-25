//Example vga_stripes_top

module vga_stripes_top(
    input wire mclk,
    input wire [3:0],
    output wire hsync, vsync,
    output wire [2:0] red, green,
    output wire [1:0] blue
);
wire clk25, clr, vidon;
wire [9:0] hc, vc;

assign clr = btn[3];

clkdiv U1 (
    .mclk(mclk), .clr(clr), .clk25(clk25)
);

vga_640x480 U2 (
    .clk(clk25), .clr(clr), .hsync(hsync), .vsync(vsync), .hc(hc), .vc(vc), .vidon(vidon)
);

vga_stripes U3 (
    .vidon(vidon), .hc(hc), .vc(vc), .red(red), .green(green), .blue(blue)
);

endmodule
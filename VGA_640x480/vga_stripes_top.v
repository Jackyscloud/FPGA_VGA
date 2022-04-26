//Example vga_stripes_top

module vga_stripes_top(
    input wire btn,
    input wire clk25;
    output wire hsync, vsync,
    output wire [2:0] red, green,
    output wire [1:0] blue
);
wire clr, vidon;
wire [9:0] hc, vc;

assign clr = btn;

vga_640x480 U1 (
    .clk(clk25), .clr(clr), .hsync(hsync), .vsync(vsync), .hc(hc), .vc(vc), .vidon(vidon)
);

vga_stripes U2 (
    .vidon(vidon), .hc(hc), .vc(vc), .red(red), .green(green), .blue(blue)
);

endmodule
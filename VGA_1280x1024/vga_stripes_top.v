//Example vga_stripes_top
//`timescale 1ns/1ps //one finish cycle set 18000ms

module vga_stripes_top(
    input wire clk,
    input wire btn,

    output wire hsync,
    output wire vsync,
    output wire [2:0] red, 
    output wire [2:0] green,
    output wire [1:0] blue
);
//function output
//wire clk25;
wire vidon;
wire [10:0] hc, vc;


/*clock_div U3 (
    .mclk(clk),
    .clr(btn),
    .clk_out(clk25)
);
*/

vga_1280x1024 U1 (
    .clk(clk), .clr(btn), .hsync(hsync), .vsync(vsync), .hc(hc), .vc(vc), .vidon(vidon)
);

vga_stripes U2 (
    .vidon(vidon), .hc(hc), .vc(vc), .red(red), .green(green), .blue(blue)
);


/*initial begin
    btn = 1;
    clk = 1'b1;
    #10 btn = 0;
end



always #5 clk = ~clk; //100MHz*/


endmodule
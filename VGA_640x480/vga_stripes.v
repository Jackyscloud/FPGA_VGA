module vga_stripes(
    input vidon,
    input [9:0] hc, vc,

    output [2:0] red, green,
    output [1:0] blue
);

// output red, green stripes 16 lines wide
always@(*)
    begin
        red = 0;
        green = 0;
        blue = 0;
        if (vidon == 1)
            begin
                red = {vc[4], vc[4], vc[4]};
                green = ~{vc[4], vc[4], vc[4]};
            end
    end
endmodule

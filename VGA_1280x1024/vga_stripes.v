module vga_stripes(
    input wire vidon,
    input wire [10:0] hc, vc,

    output reg [2:0] red, green,
    output reg [1:0] blue
);

// output red, green stripes 16 lines wide
always@(*)
    begin
        red = 0;
        green = 0;
        blue = 0;
        if (vidon == 1)
            begin
                red = 0;
                green = 3'b111;
                blue = 0;
            end
    end
endmodule
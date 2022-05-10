module vga_initials (
    input wire vidon,
    input wire [10:0] hc,
    input wire [10:0] vc,
    input wire [0:37] M,
    input wire [7:0] sw,
    output wire [4:0] rom_addr5,
    output reg [2:0] red,
    output reg [2:0] green,
    output reg [1:0] blue
);
parameter hbp = 10'b101101000;
    // horizonal back porch end = 0 + sp + bp = 0 + 112 + 248(video line start)
parameter vbp = 10'b101001;
    // vertial back porch = 41
parameter W = 38;
parameter H = 40;
wire [10:0] C1, R1, rom_addr, rom_pix;
reg spriteon, R, G, B;

assign C1 = {2'b00, sw[3:0], 5'b00001};
assign R1 = {2'b00, sw[7:4], 5'b00001};
assign rom_addr = vc - vbp - R1;
assign rom_pix = hc - hbp - C1;
assign rom_addr5 = rom_addr[4:0];

//Enalbe sprite video out when within the sprite region
always @(*)
    begin
        if ((hc >=  C1 + hbp) && (hc < C1 + hbp + W) && (vc >= R1 + vbp) && (vc < R1 + vbp + H))
            spriteon = 1;
        else
            spriteon = 0;
    end

// Output video color signals
always @(*)
    begin
        red = 0;
        green = 0;
        blue = 0;
        if ((spriteon == 1) && (vidon == 1))
            begin
                R = M[rom_pix];
                G = M[rom_pix];
                B = M[rom_pix];
                red = {R, R, R};
                green = {G, G, G};
                blue = {B, B};
            end
    end
endmodule

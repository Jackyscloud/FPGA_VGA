module vga_640x480 (
    //input
    input wire clk,
    input wire clr,

    //output
    output reg hsync,
    output reg vsync,
    output reg [9:0] hc,
    output reg [9:0] vc,
    output reg vidon
);
parameter hpixels = 10'b11001_00000; //dex 800
    // value of pixels in a horizonal line = 800
parameter vlines = 10'b1000001101;
    // number of horizonal lines in the display = 525
parameter hbp = 10'b10010000;
    // horizonal back porch end = 0 + sp + bp = 0 + 96 + 48(video line start)
parameter hfp = 10'b11000_10000;
    // horizonal front porch end = 784(video line end)
parameter vbp = 10'b100011;
    // vertial back porch = 35
parameter vfp = 10'b1000000011;
    // vertial front porch = 515
parameter hs_low = 10'b1100000;//96

parameter vs_low = 2;//2

reg vsenable; //enable for vertial counter

// Counter for the horizontal sync signal
always @(posedge clk or posedge clr)
    begin
        if (clr == 1)
            hc <= 0;
        else
            begin
                if (hc == hpixels - 1)
                    begin
                        //The counter has reached the end of pixel count
                        hc <= 0;
                        vsenable <= 1;
                    end
                else
                    begin
                        hc <= hc + 1;
                        vsenable <= 0;
                    end
            end
    end
// Generate hsync pulse
// Horizontal Sync Pulse is low when hc is 0 to hs_low
always @ (*)
    begin
        if (hc < hs_low)
            hsync = 0;
        else
            hsync = 1;
    end
// Counter for the vertical sync signal
always @(posedge clk or posedge clr)
    begin
        if (clr == 1)
            vc <= 0;
        else
            if(vsenable == 1)
                begin
                    if (vc == vlines - 1)
                        // Reset when the number of lines is reached
                        vc <= 0;
                    else
                        vc <= vc + 1; //Increment vertical counter
                end
    end

//Generate vsync pulse
// Vertical Sync Pulse is low when hc is 0 to vs_low
always @(*)
    begin
        if (vc < vs_low)
            vsync = 0;
        else
            vsync = 1;
    end

// Enable video out when within the porches
always@(*)
    begin
        if ((hc < hfp) && (hc > hbp) && (vc < vfp) && (vc > vbp))
            vidon = 1;
        else
            vidon = 0;
    end

endmodule
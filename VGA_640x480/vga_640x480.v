module vga_640x480 (
    //input
    input clk,
    input clr,

    //output
    output hsync,
    output vsync,
    output [9:0] hc,
    output [9:0] vc,
    output vidon
);
parameter hpixels = 10'b11001_00000;
    // value of pixels in a horizonal line = 800
parameter vlines = 10'b10000_01001;
    // number of horizonal lines in the display = 521
parameter hbp = 10'b00100_10000;
    // horizonal back porch = 144
parameter hfp = 10'b11000_10000;
    // horizonal front porch = 784
parameter vbp = 10'b00000_11111;
    // vertial back porch = 31
parameter vfp = 10'b01111_11111;
    // vertial front porch = 511
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
// Horizontal Sync Pulse is low when hc is 0 - 127
always @ (*)
    begin
        if (hc < 128)
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
// Vertical Sync Pulse is low when hc is 0 or 1
always @(*)
    begin
        if (vc < 2)
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
module clock_div(
    mclk,
    clr,
    clk_out
);

input mclk;
input clr;
output clk_out;

wire clk_out;
reg [2:0] q;

always @(posedge mclk or posedge clr)
begin
    if (clr) q <= 0;
    else q <= q + 1'b1;
end

assign clk_out = q[2];//div 4

endmodule

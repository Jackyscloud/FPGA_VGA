module clock_div(
    mclk,
    clr,
    clk_out
);

input mclk;
input clr;
output clk_out;

wire clk_out;
reg [25:0] q;

always @(posedge mclk)
begin
    if (clr) q <= 0;
    else q <= q + 1'b1;
end

assign clk_out = q[25];

endmodule

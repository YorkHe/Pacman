module gameover_ROM(
    clk,
    x,
    y,
    pixel
);

input [8:0] x;
input [8:0] y;

output pixel;

localparam GAMEOVER = {

    };

always @(posedge clk)
begin
    pixel <= GAMEOVER[y * 80 + x];
end


endmodule

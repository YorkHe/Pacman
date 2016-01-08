`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:22:02 01/03/2016 
// Design Name: 
// Module Name:    graphic 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module graphic(
    input wire clk, reset,
    input wire [10:0] x, y,
    input wire [3:0] btn,
    output wire [7:0] rgb
);

reg [7:0] rgb_now;

wire [1:0]map_vga_pixel;

wire [8:0] p_x, p_y;
wire clk_1ms;

localparam COLOR_BG   = 8'b00000000;
localparam COLOR_NULL = 8'b00000000;
localparam COLOR_WALL = 8'b11010000;
localparam COLOR_PACMAN = 8'b00111111;

localparam MAP_LU_X = 150;
localparam MAP_LU_Y = 50;
localparam MAP_RD_X = 497;
localparam MAP_RD_Y = 455;

localparam P_WIDTH = 23;

timer1ms timer(
    .clk(clk),
    .clk_1ms(clk_1ms)
);

pacman p(
    .clk(clk_1ms),
    .btn(btn),
    .p_x(p_x),
    .p_y(p_y)
);

mapRom map_rom(
    .x(x - MAP_LU_X),
    .y(y - MAP_LU_Y),
    .pixel(map_vga_pixel)
);

always @(posedge clk) begin
    if (x>=0 && y>=0 && x<640 && y<480) begin
        if (x>=MAP_LU_X && y>=MAP_LU_Y && x < MAP_RD_X && y < MAP_RD_Y) begin
            if (x >= (MAP_LU_X+p_x - (P_WIDTH / 2)) && 
                y >= (MAP_LU_Y+p_y - (P_WIDTH / 2)) && 
                x <  (MAP_LU_X+p_x + (P_WIDTH / 2)) && 
                y <  (MAP_LU_Y+p_y + (P_WIDTH / 2)))

                rgb_now <= COLOR_PACMAN;
            else begin
                if (map_vga_pixel == 2'b00) 
                    rgb_now <= COLOR_WALL;
                else 
                    rgb_now <= COLOR_NULL;
            end
        end else begin
            rgb_now <= COLOR_NULL;
        end
    end
end

assign rgb = rgb_now;

endmodule

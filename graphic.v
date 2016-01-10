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

reg [2:0] color_type;

wire [1:0]
    map_vga_pixel,
    map_vga_pixel_U,
    map_vga_pixel_UR,
    map_vga_pixel_R,
    map_vga_pixel_RD,
    map_vga_pixel_D,
    map_vga_pixel_DL,
    map_vga_pixel_L,
    map_vga_pixel_LU;

wire [8:0] p_x, p_y;
wire clk_1ms, clk_10mhz;
wire wen, ren;
wire [8:0] outdata;

integer i;
integer j;

localparam MAP_X_LENGTH = 29;
localparam MAP_Y_LENGTH = 34;


localparam INDEX_BG = 0;
localparam INDEX_NULL = 1;
localparam INDEX_WALL = 2;
localparam INDEX_PACMAN = 3;


localparam MAP_LU_X = 150;
localparam MAP_LU_Y = 50;
localparam MAP_RD_X = 497;
localparam MAP_RD_Y = 455;

localparam P_WIDTH = 24;

timer1ms timer(
    .clk(clk),
    .clk_1ms(clk_1ms)
);

timer10mhz timer2(
    .clk(clk),
    .clk_10mhz(clk_10mhz)
);

pacman p(
    .clk(clk_1ms),
    .btn(btn),
    .p_x(p_x),
    .p_y(p_y)
);

mapRom map_rom(
    .x(i),
    .y(j),
    .pixel(map_vga_pixel),
    .pixel_U(map_vga_pixel_U),
    .pixel_UR(map_vga_pixel_UR),
    .pixel_R(map_vga_pixel_R),
    .pixel_RD(map_vga_pixel_RD),
    .pixel_D(map_vga_pixel_D),
    .pixel_DL(map_vga_pixel_DL),
    .pixel_L(map_vga_pixel_L),
    .pixel_LU(map_vga_pixel_LU)
);

vram vram1(
    .clk(clk),
    .WEN(wen),
    .REN(ren),
    .inaddr_x(x),
    .inaddr_y(y),
    .outaddr_x(x),
    .outaddr_y(y),
    .indata(rgb_now),
    .outdata(outdata)
);

always @(posedge clk_10mhz) begin
    for (i = 0; i < 29; i = i+1)
    begin
        for (j = 0; j < 34; j = j+1)
        begin
            case (map_vga_pixel)
                0: begin

                end
                1: begin

                end
            endcase
        end
    end
end


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

module direction_flag(
    clk,
    x,
    y,
    flag_L,
    flag_U,
    flag_R,
    flag_D
);

input clk;
input [8:0] x;
input [8:0] y;

output [2:0] flag_L, flag_U, flag_R, flag_D;

mapRom L(
    .x(x - 12),
    .y(y),
    .pixel(flag_L)
),
    U(
     .x(x),
     .y(y - 12),
     .pixel(flag_U)
),
    R(
    .x(x + 12),
    .y(y),
    .pixel(flag_R)
),
    D(
    .x(x),
    .y(y + 12),
    .pixel(flag_D)
);

endmodule


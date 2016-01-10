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

wire [8:0] m_x_1, m_y_1, m_x_2, m_y_2, m_x_3, m_y_3, m_x_4, m_y_4;

localparam COLOR_BG   = 8'b00000000;
localparam COLOR_NULL = 8'b00000000;
localparam COLOR_WALL = 8'b11010000;
localparam COLOR_PACMAN = 8'b00111111;

localparam MAP_LU_X = 150;
localparam MAP_LU_Y = 50;
localparam MAP_RD_X = 497;
localparam MAP_RD_Y = 455;

localparam P_WIDTH = 24;

timer1ms timer(
    .clk(clk),
    .clk_1ms(clk_1ms)
);

monster m1( .clk(clk_1ms), .index(1), .p_x(p_x), .p_y(p_y), .m_x(m_x_1), .m_y(m_y_1)),
    m2( .clk(clk_1ms), .index(2), .p_x(p_x), .p_y(p_y), .m_x(m_x_2), .m_y(m_y_2)),
    m3( .clk(clk_1ms), .index(3), .p_x(p_x), .p_y(p_y), .m_x(m_x_3), .m_y(m_y_3));

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
                if (x >= (MAP_LU_X+m_x_1 - (P_WIDTH / 2)) && 
                    y >= (MAP_LU_Y+m_y_1 - (P_WIDTH / 2)) && 
                    x <  (MAP_LU_X+m_x_1 + (P_WIDTH / 2)) && 
                    y <  (MAP_LU_Y+m_y_1 + (P_WIDTH / 2)))
                    
                    rgb_now <= COLOR_MONSTER_1;
                else
                    if (x >= (MAP_LU_X+m_x_2 - (P_WIDTH / 2)) && 
                        y >= (MAP_LU_Y+m_y_2 - (P_WIDTH / 2)) && 
                        x <  (MAP_LU_X+m_x_2 + (P_WIDTH / 2)) && 
                        y <  (MAP_LU_Y+m_y_2 + (P_WIDTH / 2)))
                    
                        rgb_now <= COLOR_MONSTER_2;
                        else
                            if (x >= (MAP_LU_X+m_x_3 - (P_WIDTH / 2)) && 
                                y >= (MAP_LU_Y+m_y_3 - (P_WIDTH / 2)) && 
                                x <  (MAP_LU_X+m_x_3 + (P_WIDTH / 2)) && 
                                y <  (MAP_LU_Y+m_y_3 + (P_WIDTH / 2)))
                                rgb_now <= COLOR_MONSTER_3;
                                else
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


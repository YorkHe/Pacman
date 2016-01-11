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
    output wire [7:0] rgb,
    output wire [15:0] score
);

reg [7:0] rgb_now;

wire [1:0]map_vga_pixel;

wire [8:0] p_x, p_y;
wire clk_1ms;

wire [8:0] m_x_1, m_y_1, m_x_2, m_y_2, m_x_3, m_y_3;

reg [1:0] mon_id_1, mon_id_2, mon_id_3;

wire [1:0] pixel_D, pixel_R, pixel_RD;

wire dot;

wire flag_col_1, flag_col_2, flag_col_3;

wire [3:0] direction;

localparam L = 4'b1000;
localparam U = 4'b0100;
localparam R = 4'b0010;
localparam D = 4'b0001;

localparam COLOR_BG   = 8'b00000000;
localparam COLOR_NULL = 8'b00000000;
localparam COLOR_WALL = 8'b11010000;
localparam COLOR_PACMAN = 8'b00111111;
localparam COLOR_DOT    = 8'b11111111;
localparam COLOR_MONSTER_1 = 8'b01110111;
localparam COLOR_MONSTER_2 = 8'b00111000;
localparam COLOR_MONSTER_3 = 8'b01011010;

localparam MAP_LU_X = 150;
localparam MAP_LU_Y = 50;
localparam MAP_RD_X = 498;
localparam MAP_RD_Y = 458;

localparam P_WIDTH = 24;

localparam MON_ID_1 = 0;
localparam MON_ID_2 = 1;
localparam MON_ID_3 = 2;

initial begin
    mon_id_1 <= MON_ID_1;
    mon_id_2 <= MON_ID_2;
    mon_id_3 <= MON_ID_3;
end

timer1ms timer(
    .clk(clk),
    .clk_1ms(clk_1ms)
);

monster m1(.clk_50mhz(clk), .clk(clk_1ms), .index(mon_id_1), .p_x(p_x), .p_y(p_y), .m_x(m_x_1), .m_y(m_y_1)),
    m2(.clk_50mhz(clk), .clk(clk_1ms), .index(mon_id_2), .p_x(p_x), .p_y(p_y), .m_x(m_x_2), .m_y(m_y_2)),
    m3(.clk_50mhz(clk), .clk(clk_1ms), .index(mon_id_3), .p_x(p_x), .p_y(p_y), .m_x(m_x_3), .m_y(m_y_3));

pacman p(
    .clk_50mhz(clk),
    .clk(clk_1ms),
    .btn(btn),
    .p_x(p_x),
    .p_y(p_y),
    .going_direction(direction)
);

mapRom map_rom(
    .x(x - MAP_LU_X),
    .y(y - MAP_LU_Y),
    .pixel(map_vga_pixel),
    .pixel_R(pixel_R),
    .pixel_D(pixel_D),
    .pixel_RD(pixel_RD)
);

dotMap dots(
    .clk(clk_1ms),
    .set_x(p_x),
    .set_y(p_y),
    .query_x(x - MAP_LU_X),
    .query_y(y - MAP_LU_Y),
    .dot(dot),
    .score(score)
);

collision_detection 
collide_1(
    .clk(clk),
    .p_x(p_x),
    .p_y(p_y),
    .m_x(m_x_1),
    .m_y(m_y_1),
    .col(flag_col_1)
),collide_2(
    .clk(clk),
    .p_x(p_x),
    .p_y(p_y),
    .m_x(m_x_2),
    .m_y(m_y_2),
    .col(flag_col_2)
),collide_3(
    .clk(clk),
    .p_x(p_x),
    .p_y(p_y),
    .m_x(m_x_3),
    .m_y(m_y_3),
    .col(flag_col_3)
);

mapPac pac(
    .clk(clk),
    .x(x - MAP_LU_X - p_x + (P_WIDTH / 2)),
    .y(y - MAP_LU_Y - p_y + (P_WIDTH / 2)),
    .direction(direction),
    .pixel(pac_pixel)
);

wire gameover;

assign gameover = flag_col_1 || flag_col_2 || flag_col_3;

always @(posedge clk) begin
    if (x>=0 && y>=0 && x<640 && y<480) begin
        if (x>=MAP_LU_X && y>=MAP_LU_Y && x < MAP_RD_X && y < MAP_RD_Y) begin
            if (x >= (MAP_LU_X+p_x - (P_WIDTH / 2)) && 
                y >= (MAP_LU_Y+p_y - (P_WIDTH / 2)) && 
                x <  (MAP_LU_X+p_x + (P_WIDTH / 2)) && 
                y <  (MAP_LU_Y+p_y + (P_WIDTH / 2)))

                rgb_now <= (pac_pixel == 0)?COLOR_NULL:COLOR_PACMAN;
            else begin
                if (x >= (MAP_LU_X+m_x_1 - (P_WIDTH / 2)) && 
                    y >= (MAP_LU_Y+m_y_1 - (P_WIDTH / 2)) && 
                    x <  (MAP_LU_X+m_x_1 + (P_WIDTH / 2)) && 
                    y <  (MAP_LU_Y+m_y_1 + (P_WIDTH / 2)) && !gameover)
                    
                    rgb_now <= COLOR_MONSTER_1;
                else
                    if (x >= (MAP_LU_X+m_x_2 - (P_WIDTH / 2)) && 
                        y >= (MAP_LU_Y+m_y_2 - (P_WIDTH / 2)) && 
                        x <  (MAP_LU_X+m_x_2 + (P_WIDTH / 2)) && 
                        y <  (MAP_LU_Y+m_y_2 + (P_WIDTH / 2)) && !gameover)
                    
                        rgb_now <= COLOR_MONSTER_2;
                        else
                            if (x >= (MAP_LU_X+m_x_3 - (P_WIDTH / 2)) && 
                                y >= (MAP_LU_Y+m_y_3 - (P_WIDTH / 2)) && 
                                x <  (MAP_LU_X+m_x_3 + (P_WIDTH / 2)) && 
                                y <  (MAP_LU_Y+m_y_3 + (P_WIDTH / 2)) && !gameover)
                                rgb_now <= COLOR_MONSTER_3;
                                else
                                    if (map_vga_pixel == 2'b00) 
                                        if (!gameover)
                                            rgb_now <= COLOR_WALL;
                                        else begin
                                            rgb_now <= COLOR_DOT;
                                        end
                                    else 
                                    begin
                                        if (map_vga_pixel == 2'b01)
                                        begin
                                            if (pixel_R == 1 && pixel_D == 1 && pixel_RD == 1)
                                                if((x % 12 >=11  || x % 12 <= 0) && (y % 12 >= 11 || y % 12 <= 0) && dot)
                                                    rgb_now <= COLOR_DOT;
                                                else 
                                                    rgb_now <= COLOR_NULL;
                                            else
                                                rgb_now <= COLOR_NULL;
                                        end else
                                            rgb_now <= COLOR_NULL;
                                    end
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

wire [2:0] flag_CL, flag_CU, flag_CR, flag_CD;
wire [2:0] flag_LL, flag_LU, flag_LR, flag_LD, flag_UL, flag_UU, flag_UR, flag_UD, flag_RL, flag_RU, flag_RR, flag_RD, flag_DL, flag_DU, flag_DR, flag_DD;

reg [8:0] adj_x_L, adj_y_L, adj_x_U, adj_y_U, adj_x_R, adj_y_R, adj_x_D, adj_y_D;

initial begin
    adj_x_L = x - 11;
    adj_y_L = y;

    adj_x_U = x;
    adj_y_U = y - 11;

    adj_x_R = x + 11;
    adj_y_R = y;

    adj_x_D = x;
    adj_y_D = y + 11;
end

assign flag_L = flag_CL && flag_UL && flag_DL;
assign flag_U = flag_CU && flag_LU && flag_RU;
assign flag_R = flag_CR && flag_UR && flag_DR;
assign flag_D = flag_CD && flag_LD && flag_RD;


mapRom L(
    .x(x - 13),
    .y(y),
    .pixel(flag_CL)
),
    U(
     .x(x),
     .y(y - 13),
     .pixel(flag_CU)
),
    R(
    .x(x + 12),
    .y(y),
    .pixel(flag_CR)
),
    D(
    .x(x),
    .y(y + 12),
    .pixel(flag_CD)
);


mapRom 
    L_U(
     .x(adj_x_L),
     .y(adj_y_L - 13),
     .pixel(flag_LU)
),
    L_D(
    .x(adj_x_L),
    .y(adj_y_L + 12),
    .pixel(flag_LD)
);


mapRom U_L(
    .x(adj_x_U - 13),
    .y(adj_y_U),
    .pixel(flag_UL)
),
    U_R(
    .x(adj_x_U + 12),
    .y(adj_y_U),
    .pixel(flag_UR)
);


mapRom 
    R_U(
     .x(adj_x_R),
     .y(adj_y_R - 13),
     .pixel(flag_RU)
),
    R_D(
    .x(adj_x_R),
    .y(adj_y_R + 12),
    .pixel(flag_RD)
);

mapRom D_L(
    .x(adj_x_D - 13),
    .y(adj_y_D),
    .pixel(flag_DL)
),
    D_R(
    .x(adj_x_D + 12),
    .y(adj_y_D),
    .pixel(flag_DR)
);

endmodule


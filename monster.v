`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:24 01/04/2016 
// Design Name: 
// Module Name:    monster 
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
module monster(
    clk_50mhz,
    clk,
    index,
    p_x,
    p_y,
    m_x,
    m_y
);

input clk_50mhz;
input clk;
input [1:0] index;
input [8:0] p_x, p_y;
output reg [8:0] m_x, m_y;

localparam MON_VELOCITY = 1;

localparam MON_ID_1 = 0;
localparam MON_ID_2 = 1;
localparam MON_ID_3 = 2;

localparam L = 4'b1000;
localparam U = 4'b0100;
localparam R = 4'b0010;
localparam D = 4'b0001;

localparam m1_pos_x = 20;
localparam m1_pos_y = 200;

localparam m2_pos_x = 300;
localparam m2_pos_y = 200;

localparam m3_pos_x = 100;
localparam m3_pos_y = 30;


reg [3:0] going_direction;
wire [2:0] flag_L, flag_U, flag_R, flag_D;
wire collide_L, collide_U, collide_R, collide_D;

reg v_direction, h_direction;
reg [1:0] rand;

initial begin
    case(index)
        MON_ID_1: begin
            m_x<=m1_pos_x;
            m_y<=m1_pos_y;
            going_direction <= U;
        end
        MON_ID_2: begin
            m_x<=m2_pos_x;
            m_y<=m2_pos_y;
            going_direction <= L;
        end
        MON_ID_3: begin
            m_x<=m3_pos_x;
            m_y<=m3_pos_y;
            going_direction <= R;
        end
    endcase

    m_x <= 100;
    m_y <= 30;
    going_direction <= R;
    rand <= {$random} % 10;
end


direction_flag flag2(
    .clk(clk_50mhz),
    .x(m_x),
    .y(m_y),
    .flag_L(flag_L),
    .flag_U(flag_U),
    .flag_R(flag_R),
    .flag_D(flag_D)
);

always @(posedge clk) begin
    case (going_direction)
        4'b1000:
        begin
            if (flag_L != 0) begin
                m_x <= m_x - MON_VELOCITY;
            end 
        end
        4'b0100:
        begin
            if (flag_U != 0) begin
                m_y <= m_y - MON_VELOCITY;
            end 
        end
        4'b0010:
        begin
            if (flag_R != 0) begin
                m_x <= m_x + MON_VELOCITY;
            end 
        end
        4'b0001:
        begin
            if (flag_D != 0) begin
                m_y <= m_y + MON_VELOCITY;
            end 
        end
    endcase
end

always @(posedge clk_50mhz) begin
    h_direction <= (p_x - m_x >= 0)? 1 : 0;
    v_direction <= (p_y - m_y >= 0)? 1 : 0;
end


always @(posedge clk) begin
    case(going_direction)
        4'b1000:
        begin
            if (flag_L == 0)
            begin
                if (v_direction == 1)
                begin
                    if (flag_D != 0)
                        going_direction <= D;
                    else 
                        going_direction <= U;
                end else
                begin
                    if (flag_U != 0)
                        going_direction <= U;
                    else
                        going_direction <= D;
                end
            end 
        end
        4'b0100:
        begin
            if (flag_U == 0)
            begin
                if (h_direction == 1)
                begin
                    if (flag_R != 0)
                        going_direction <= R;
                    else
                        going_direction <= L;
                end else
                begin
                    if (flag_L != 0)
                        going_direction <= L;
                    else
                        going_direction <= R;
                end
            end 
        end
        4'b0010:
        begin
            if (flag_R == 0)
            begin
                if (v_direction == 1)
                begin
                    if (flag_D != 0)
                        going_direction <= D;
                    else 
                        going_direction <= U;
                end else
                begin
                    if (flag_U != 0)
                        going_direction <= U;
                    else
                        going_direction <= D;
                end
            end 
        end
        4'b0001:
        begin
            if (flag_D == 0)
            begin
                if (h_direction == 1)
                begin
                    if (flag_R != 0)
                        going_direction <= R;
                    else
                        going_direction <= L;
                end else
                begin
                    if (flag_L != 0)
                        going_direction <= L;
                    else
                        going_direction <= R;
                end
            end 
        end
    endcase
end
endmodule

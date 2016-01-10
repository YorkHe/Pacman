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
    clk,
    index,
    p_x,
    p_y,
    m_x,
    m_y
);

input clk;
input [2:0] index;
input [8:0] p_x, p_y;
output reg [8:0] m_x, m_y;

localparam MON_VELOCITY = 1;

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

wire v_direction, h_direction;

initial begin

    /*
    case(index)
        1: begin
            m_x<=m1_pos_x;
            m_y<=m1_pos_y;
        end
        2: begin
            m_x<=m2_pos_x;
            m_y<=m2_pos_y;
        end
        3: begin
            m_x<=m3_pos_x;
            m_y<=m3_pos_y;
        end
    endcase
    */
   m_x <= 84;
   m_y <= 100;
   going_direction <= U;
end

assign h_direction = (p_x - m_x > 0)? 1 : 0;
assign v_direction = (p_y - m_y > 0)? 1 : 0;

direction_flag flag2(
    .clk(clk),
    .x(m_x),
    .y(m_y),
    .flag_L(flag_L),
    .flag_U(flag_U),
    .flag_R(flag_R),
    .flag_D(flag_D)
);

collision_detection(
    .clk(clk),
    .direction(L),
    .p_x(m_x),
    .p_y(m_y),
    .collide(collide_L)
);

collision_detection(
    .clk(clk),
    .direction(U),
    .p_x(m_x),
    .p_y(m_y),
    .collide(collide_U)
);

collision_detection(
    .clk(clk),
    .direction(R),
    .p_x(m_x),
    .p_y(m_y),
    .collide(collide_R)
);

collision_detection(
    .clk(clk),
    .direction(D),
    .p_x(m_x),
    .p_y(m_y),
    .collide(collide_D)
);

always @(posedge clk) begin
    case (going_direction)
        4'b1000:
        begin
            if (!collide_L) begin
                m_x <= m_x - MON_VELOCITY;
                if (flag_U != 0)
                    m_y <= m_y - m_y % 12;
                else
                    m_y <= m_y + 12 - m_y % 12;
            end
        end
        4'b0100:
        begin
            if (!collide_U) begin
                if (flag_L != 0)
                    m_x <= m_x - m_x % 12;
                else
                    m_x <= m_x + 12 - m_x % 12;
                m_y <= m_y - MON_VELOCITY;
            end
        end
        4'b0010:
        begin
            if (!collide_R) begin
                m_x <= m_x + MON_VELOCITY;
                if (flag_U != 0)
                    m_y <= m_y - m_y % 12;
                else
                    m_y <= m_y + 12 - m_y % 12;
            end
        end
        4'b0001:
        begin
            if (!collide_D) begin
                if (flag_L != 0)
                    m_x <= m_x - m_x % 12;
                else
                    m_x <= m_x + 12 - m_x % 12;
                m_y <= m_y + MON_VELOCITY;
            end
        end
    endcase
end

always @(posedge clk) begin
    case(going_direction)
        4'b1000:
        begin
            case(v_direction)
                0: begin
                    if (flag_U != 0) begin
                        going_direction <= U;
                    end else begin
                        if (flag_D != 0)
                            going_direction <= D;
                    end
                end
                1: begin
                    if (flag_D != 0) begin
                        going_direction <= D;
                    end else begin
                        if (flag_U != 0)
                            going_direction <= U;
                    end
                end
            endcase
        end
        4'b0100:
        begin
            case(h_direction)
                0: begin
                    if (flag_L != 0) begin
                        going_direction <= L;
                    end else begin
                        if (flag_R != 0)
                            going_direction <= R;
                    end
                end
                1: begin
                    if (flag_R != 0) begin
                        going_direction <= R;
                    end else begin
                        if (flag_L != 0)
                            going_direction <= L;
                    end
                end
            endcase
        end
        4'b0010:
        begin
            case(v_direction)
                0: begin
                    if (flag_U != 0) begin
                        going_direction <= U;
                    end else begin
                        if (flag_D != 0)
                            going_direction <= D;
                    end
                end
                1: begin
                    if (flag_D != 0) begin
                        going_direction <= D;
                    end else begin
                        if (flag_U != 0)
                            going_direction <= U;
                    end
                end
            endcase
        end
        4'b0001:
        begin
            case(h_direction)
                0: begin
                    if (flag_L != 0) begin
                        going_direction <= L;
                    end else begin
                        if (flag_R != 0)
                            going_direction <= R;
                    end
                end
                1: begin
                    if (flag_R != 0) begin
                        going_direction <= R;
                    end else begin
                        if (flag_L != 0)
                            going_direction <= L;
                    end
                end
            endcase
        end
    endcase
end

endmodule

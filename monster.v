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
    input [8:0] p_x, p_y;
    output reg [8:0] m_x, m_y;

    localparam MON_VELOCITY = 1;

    localparam L = 4'b1000;
    localparam U = 4'b0100;
    localparam R = 4'b0010;
    localparam D = 4'b0001;

    localparam m1_pos_x = 0;
    localparam m1_pos_y = 0;

    localparam m2_pos_x = 0;
    localparam m2_pos_y = 0;

    localparam m3_pos_x = 0;
    localparam m3_pos_y = 0;

    initial begin
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
    end

    direction_flag flag2(
        .clk(clk),
        .x(m_x),
        .y(m_y),
        .flag_L(flag_L),
        .flag_U(flag_U),
        .flag_R(flag_R),
        .flag_D(flag_D)
    );

    always @(posedge clk) begin

    end




endmodule

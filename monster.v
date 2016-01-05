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
    p_x,
    p_y,
    x,
    y,
    index
    );

    input clk;
    input [8:0] p_x, p_y;
    output reg [8:0] x, y;

    localparam m1_pos_x = 0;
    localparam m1_pos_y = 0;

    localparam m2_pos_x = 0;
    localparam m2_pos_y = 0;

    localparam m3_pos_x = 0;
    localparam m3_pos_y = 0;

    initial begin
        case(index)
        begin
            1: begin
                x<=m1_pos_x;
                y<=m1_pos_y;
            end
            2: begin
                x<=m2_pos_x;
                y<=m2_pos_y;
            end
            3: begin
                x<=m3_pos_x;
                y<=m3_pos_y;
            end
        end
    end


endmodule

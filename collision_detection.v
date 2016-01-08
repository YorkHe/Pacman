`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:04 01/06/2016 
// Design Name: 
// Module Name:    collision_detection 
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
module collision_detection(
    clk,
    direction,
    p_x,
    p_y,
    collide
    );

    input clk;
    input [3:0] direction;
    input [8:0] p_x;
    input [8:0] p_y;

    output collide;

    reg [8:0] det_x_1;
    reg [8:0] det_y_1;

    reg [8:0] det_x_2;
    reg [8:0] det_y_2;


    reg [8:0] det_x_3;
    reg [8:0] det_y_3;



  //  wire [2:0] pixel_1, pixel_2, pixel_3;
    reg [2:0] pixel;
    wire [2:0] flag_L, flag_D, flag_R, flag_U;

    localparam step = 13;

    assign collide = (pixel == 0);

    direction_flag dir(
        .clk(clk),
        .x(p_x),
        .y(p_y),
        .flag_L(flag_L),
        .flag_U(flag_U),
        .flag_R(flag_R),
        .flag_D(flag_D)
    );

    always @(posedge clk)
    begin
        case(direction)
            4'b1000: pixel <= flag_L;
            4'b0100: pixel <= flag_U;
            4'b0010: pixel <= flag_R;
            4'b0001: pixel <= flag_D;
        endcase
    end


endmodule

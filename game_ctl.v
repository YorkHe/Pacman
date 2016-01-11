`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:36 01/04/2016 
// Design Name: 
// Module Name:    game_ctl 
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
module gameCtl(
    clk,
    btn,
    reset,
    hsync,
    vsync,
    rgb,
    seg,
    an
    );

    input clk;
    input [3:0]btn;
    input reset;
    output hsync, vsync;
    output [7:0] rgb;
    output [7:0] seg;
    output [3:0] an;


    wire [8:0] m1_x, m1_y, m2_x, m2_y, m3_x, m3_y;
    wire [8:0] p_x, p_y;
    wire clk_1ms;

    wire [10:0] x, y;

    wire [15:0] score;


    timer1ms timer(
        .clk(clk),
        .clk_1ms(clk_1ms)
    );

    vga_sync vga(
        .clk(clk),
        .hsync(hsync),
        .vsync(vsync),
        .x(x),
        .y(y)
    );

    graphic g(
         .clk(clk),
         .reset(reset_out),
         .x(x),
         .y(y),
         .rgb(rgb),
         .btn(btn),
         .score(score)
    );

    seg seven_seg(
        .clk(clk),
        .disp_num(score),
        .dpdot(4'b0000),
        .segment(seg),
        .an(an)
    );

endmodule


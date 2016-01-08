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
    rgb
    );

    input clk;
    input [3:0]btn;
    input reset;
    output hsync, vsync;
    output [7:0] rgb;


    wire [8:0] m1_x, m1_y, m2_x, m2_y, m3_x, m3_y;
    wire [8:0] p_x, p_y;
    wire clk_1ms;

    wire [10:0] x, y;

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
    /*
    monster
        m1(.clk(clk_1ms), .p_x(p_x), .p_y(p_y), .x(m1_x), y(m1_y)),
        m2(.clk(clk_1ms), .p_x(p_x), .p_y(p_y), .x(m2_x), y(m2_y)),
        m3(.clk(clk_1ms), .p_x(p_x), .p_y(p_y), .x(m3_x), y(m3_y));

    pacman p(.clk(clk_1ms), .btn(btn), .p_x(p_x), .p_y(p_y));
    */

    graphic g(
         .clk(clk),
         .reset(reset_out),
         .x(x),
         .y(y),
         .rgb(rgb),
         .btn(btn)
    );

endmodule

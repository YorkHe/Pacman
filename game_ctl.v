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
module game_ctl(
    clk,
    btn,
    reset,
    hsync,
    vsync,
    rgb
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
         .btn(btn_out)
    );




endmodule

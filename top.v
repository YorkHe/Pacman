`timescale 2ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:38 01/03/2016 
// Design Name: 
// Module Name:    top 
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
module top(
    clk,
    reset,
    btn,
    hsync,
    vsync,
    rgb
    );

    input clk;
    input reset;
    input [3:0] btn;
    output hsync, vsync;
    output [7:0] rgb;




    wire reset_out;
    wire [3:0] btn_out;
    wire [10:0] x, y;
    vga_sync vga(
        .clk(clk),
        .hsync(hsync),
        .vsync(vsync),
        .x(x),
        .y(y)
    );

    debounce 
        BTNL(clk, btn[0], btn_out[0]),
        BTNU(clk, btn[1], btn_out[1]),
        BTNR(clk, btn[2], btn_out[2]),
        BTND(clk, btn[3], btn_out[3]),
        RES(clk, reset, reset_out);



    graphic g(
         .clk(clk),
         .reset(reset_out),
         .x(x),
         .y(y),
         .rgb(rgb),
         .btn(btn_out)
    );

endmodule

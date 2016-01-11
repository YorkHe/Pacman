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
    rgb,
    seg,
    an
    );

    input clk;
    input reset;
    input [3:0] btn;
    output hsync, vsync;
    output [7:0] rgb;
    output [7:0] seg;
    output [3:0] an;

    wire reset_out;
    wire [3:0] btn_out;

    debounce 
        BTNL(clk, btn[0], btn_out[0]),
        BTNU(clk, btn[1], btn_out[1]),
        BTNR(clk, btn[2], btn_out[2]),
        BTND(clk, btn[3], btn_out[3]),
        RES(clk, reset, reset_out);

    gameCtl ctl(
        .clk(clk),
        .btn(btn_out),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .rgb(rgb),
        .seg(seg),
        .an(an)
    );

endmodule

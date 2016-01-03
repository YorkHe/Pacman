`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:13 12/27/2015 
// Design Name: 
// Module Name:    vga 
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

module vga_sync
(
    input wire clk,
    output wire hsync, vsync,
    output wire [10:0] x, y
);


    reg [10:0] cnt_x, cnt_y;
    reg in_hs, in_vs;
    wire clk_pixel;

    localparam H_PW     = 10'd96;
    localparam H_BP     = 10'd48;
    localparam H_DISP   = 10'd640;
    localparam H_FP     = 10'd16;
    localparam H_S      = H_PW + H_BP + H_DISP + H_FP;


    localparam V_PW     = 10'd2;
    localparam V_BP     = 10'd33;
    localparam V_DISP   = 10'd480;
    localparam V_FP     = 10'd10;
    localparam V_S      = V_PW + V_BP + V_DISP + V_FP;

    clk_pixel clk0(clk, clk_pixel);

    wire cnt_x_maxed = (cnt_x == H_S-1);
    wire cnt_y_maxed = (cnt_y == V_S-1);

    initial begin
        cnt_x <= 0;
        cnt_y <= 0;
    end

    always @(posedge clk_pixel) begin
        if (cnt_x_maxed) begin
            cnt_x <= 0;
            cnt_y <= cnt_y + 1'b1;
            if (cnt_y_maxed)
                cnt_y <= 0;
        end
        else
            cnt_x <= cnt_x + 1'b1;
    end

    always @(posedge clk_pixel) begin
        in_hs = (cnt_x < H_PW);
        in_vs = (cnt_y < V_PW);
    end

    assign hsync = ~in_hs;
    assign vsync = ~in_vs;

    assign x = cnt_x - (H_PW + H_BP);
    assign y = cnt_y - (V_PW + V_BP);

endmodule


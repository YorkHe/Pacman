`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:22:02 01/03/2016 
// Design Name: 
// Module Name:    graphic 
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
module graphic(
    input wire clk, reset,
    input wire [10:0] x, y,
    input wire [3:0] btn,
    output wire [7:0] rgb
    );

    reg [7:0] rgb_now;

    wire [1:0]map_vga_pixel;

    localparam COLOR_BG   = 8'b01001000;
    localparam COLOR_NULL = 8'b00000000;
    localparam COLOR_WALL = 8'b01000000;

    localparam MAP_LU_X = 120;
    localparam MAP_LU_Y = 50;
    localparam MAP_RD_X = 475;
    localparam MAP_RD_Y = 450;


    mapRom map_rom(
        .x(x - MAP_LU_X),
        .y(y - MAP_LU_Y),
        .pixel(map_vga_pixel)
    );

    always @(posedge clk) begin
        if (x>=0 && y>=0 && x<640 && y<480) begin
            if (x>=MAP_LU_X && y>=MAP_LU_Y && x < MAP_RD_X && y < MAP_RD_Y) begin
                if (map_vga_pixel == 2'b00) begin
                    rgb_now <= COLOR_WALL;
                end
                else begin
                    rgb_now <= COLOR_NULL;
                end
            end
            else
                rgb_now <= COLOR_BG;
        end else begin
            rgb_now <= COLOR_NULL;
        end
    end

    assign rgb = rgb_now;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:39 01/10/2016 
// Design Name: 
// Module Name:    vram 
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
module vram(
    clk,
    WEN,
    REN,
    inaddr_x,
    inaddr_y,
    outaddr_x,
    outaddr_y,
    indata,
    outdata
    );

    input clk;
    input WEN, REN;
    input [10:0] inaddr_x, inaddr_y;
    input [10:0] outaddr_x, outaddr_y;

    input [2:0] indata;

    output [7:0] outdata;

    wire [2:0] vram_Data_out;

    reg [2:0] vram [640*480:0];

    color_map  
         map_out(.clk(clk), .in(vram_Data_out), out(outdata));

    always @(posedge clk)
    begin
        if (WEN)
        begin
            vram[inaddr_x + 640 * inaddr_y] <= indata;
        end
    end

    always @(posedge clk)
    begin
        if (REN)
        begin
            vram_Data_out <= vram[outaddr_x + 640 * outaddr_y];
        end
    end

endmodule

module color_map(
    clk,
    in,
    out
);

input clk;
input [1:0] in;
output reg [7:0] out;

localparam INDEX_BG = 0;
localparam INDEX_NULL = 1;
localparam INDEX_WALL = 2;
localparam INDEX_PACMAN = 3;

localparam COLOR_BG = 8'b00000000;
localparam COLOR_NULL = 8'b00000000;
localparam COLOR_WALL = 8'b11010000;
localparam COLOR_PACMAN = 8'b00111111;

always @(posedge clk)
begin
    case (in)
        INDEX_BG:
            out <= COLOR_BG;
        INDEX_NULL:
            out <= COLOR_NULL;
        INDEX_PACMAN:
            out <= COLOR_PACMAN;
        INDEX_WALL:
            out <= COLOR_WALL;
    endcase
end

endmodule

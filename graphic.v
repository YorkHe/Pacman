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

    localparam COLOR_BG   = 8'b01001000;
    localparam COLOR_NULL = 8'b00000000;
    localparam COLOR_BALL = 8'b11011101;

    always @(posedge clk) begin
        if (x>=0 && y>=0 && x<640 && y<480) begin
            if (x>=300 && y>=300 && x < 350 && y < 350) begin
                rgb_now <= COLOR_BALL;
            end
            else
                rgb_now <= COLOR_BG;
        end else begin
            rgb_now <= COLOR_NULL;
        end
    end

    assign rgb = rgb_now;

endmodule

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

    reg [8:0] det_x;
    reg [8:0] det_y;

    wire [2:0] pixel;

    localparam step = 13;

    assign collide = (pixel == 0);

    always @(posedge clk)
    begin
        case(direction)
            4'b1000:
            begin
                det_x <= p_x - step;
                det_y <= p_y;
            end
            4'b0100:
            begin
                det_x <= p_x;
                det_y <= p_y - step;
            end
            4'b0010:
            begin
                det_x <= p_x + step;
                det_y <= p_y;
            end
            4'b0001:
            begin
                det_x <= p_x;
                det_y <= p_y + step;
            end
        endcase
    end

    mapRom map_rom(
        det_x,
        det_y,
        pixel
    );

endmodule

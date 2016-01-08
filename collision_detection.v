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

    reg [8:0] det_x_1;
    reg [8:0] det_y_1;

    reg [8:0] det_x_2;
    reg [8:0] det_y_2;


    reg [8:0] det_x_3;
    reg [8:0] det_y_3;



    wire [2:0] pixel_1, pixel_2, pixel_3;

    localparam step = 12;

    assign collide = (pixel_1 == 0) || (pixel_2==0)|| (pixel_3==0);

    always @(posedge clk)
    begin
        case(direction)
            4'b1000:
            begin
                det_x_1 <= p_x - step;
                det_y_1 <= p_y;

                det_x_2 <= p_x - (step-4);
                det_y_2 <= p_y + (step-4);

                det_x_3 <= p_x - (step-4);
                det_y_3 <= p_y - (step-4);
            end
            4'b0100:
            begin
                det_x_1 <= p_x;
                det_y_1 <= p_y - step;

                det_x_2 <= p_x - (step-4);
                det_y_2 <= p_y - (step-4);

                det_x_3 <= p_x + (step-4);
                det_y_3 <= p_y - (step-4);
            end
            4'b0010:
            begin
                det_x_1 <= p_x + step;
                det_y_1 <= p_y;

                det_x_2 <= p_x + (step-4);
                det_y_2 <= p_y - (step-4);

                det_x_3 <= p_x + (step-4);
                det_y_3 <= p_y + (step-4);
            end
            4'b0001:
            begin
                det_x_1 <= p_x;
                det_y_1 <= p_y + step;

                det_x_2 <= p_x - (step-4);
                det_y_2 <= p_y + (step-4);

                det_x_3 <= p_x + (step-4);
                det_y_3 <= p_y + (step-4);
            end
        endcase
    end

    mapRom map_rom1(
        det_x_1,
        det_y_1,
        pixel_1
    );
    mapRom map_rom2(
        det_x_2,
        det_y_2,
        pixel_2
    );
    mapRom map_rom3(
        det_x_3,
        det_y_3,
        pixel_3
    );




endmodule

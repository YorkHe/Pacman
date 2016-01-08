`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:37 01/04/2016 
// Design Name: 
// Module Name:    pacman 
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
module pacman(
    clk,
    btn,
    p_x,
    p_y
);

input clk;
input [3:0] btn;
output reg [8:0] p_x;
output reg [8:0] p_y;


localparam PAC_VELOCITY = 1;

localparam L = 4'b1000;
localparam U = 4'b0100;
localparam R = 4'b0010;
localparam D = 4'b0001;

wire collide_L, collide_U, collide_R, collide_D;

initial begin
    p_x <= 200;
    p_y <= 230;
end

collision_detection(
    .clk(clk),
    .direction(L),
    .p_x(p_x),
    .p_y(p_y),
    .collide(collide_L)
);

collision_detection(
    .clk(clk),
    .direction(U),
    .p_x(p_x),
    .p_y(p_y),
    .collide(collide_U)
);

collision_detection(
    .clk(clk),
    .direction(R),
    .p_x(p_x),
    .p_y(p_y),
    .collide(collide_R)
);

collision_detection(
    .clk(clk),
    .direction(D),
    .p_x(p_x),
    .p_y(p_y),
    .collide(collide_D)
);

always @(posedge clk)
begin
    case(btn)
        4'b1000:
        begin
            if (!collide_L)
               p_x <= p_x - PAC_VELOCITY;
        end

        4'b0100:
        begin
            if (!collide_U)
               p_y <= p_y - PAC_VELOCITY;
        end

        4'b0010:
        begin
            if (!collide_R)
              p_x <= p_x + PAC_VELOCITY;
        end

        4'b0001:
        begin
            if (!collide_D)
               p_y <= p_y + PAC_VELOCITY;
        end
        default:
        begin
            p_x <= p_x;
            p_y <= p_y;
        end
    endcase
end

endmodule

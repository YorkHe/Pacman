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
    clk_50mhz,
    clk,
    btn,
    p_x,
    p_y
);

input clk_50mhz;
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
wire [2:0] flag_L, flag_U, flag_R, flag_D;

reg [3:0] going_direction;

initial begin
    p_x <= 200;
    p_y <= 230;
    going_direction <= 4'b1111;
end

direction_flag flag(
    .clk(clk_50mhz),
    .x(p_x),
    .y(p_y),
    .flag_L(flag_L),
    .flag_U(flag_U),
    .flag_R(flag_R),
    .flag_D(flag_D)
);


always @(posedge clk_50mhz)
begin
    case(btn)
        4'b1000:
        begin
            if (flag_L != 0)
                going_direction <= L;
        end

        4'b0100:
        begin
            if (flag_U != 0)
                going_direction <= U;
        end

        4'b0010:
        begin
            if (flag_R != 0)
                going_direction <= R;
        end

        4'b0001:
        begin
            if (flag_D != 0)
                going_direction <= D;
        end
    endcase
end

always @(posedge clk)
begin
    case(going_direction)
        4'b1000:
        begin
            if (flag_L != 0) begin
                p_x <= p_x - PAC_VELOCITY;
            end 
        end

        4'b0100:
        begin
            if (flag_U != 0) begin
                p_y <= p_y - PAC_VELOCITY;
            end 
        end

        4'b0010:
        begin
            if (flag_R != 0) begin
                p_x <= p_x + PAC_VELOCITY;
            end 
        end

        4'b0001:
        begin
            if (flag_D != 0) begin
                p_y <= p_y + PAC_VELOCITY;
            end 
        end
    endcase
end

endmodule

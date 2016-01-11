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
    p_x,
    p_y,
    m_x,
    m_y,
    col
);


input clk;
input [8:0] p_x, p_y, m_x, m_y;
output col;

integer distance;

assign col = (distance < 12);

always @(posedge clk)
begin
    distance = (p_x - m_x) * (p_x - m_x) + (p_y - m_y)*(p_y - m_y);
end



endmodule

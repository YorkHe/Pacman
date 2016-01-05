`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:29:27 01/06/2016 
// Design Name: 
// Module Name:    seg 
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
module seg(
        clk,
        disp_num,
        dpdot,
        segment,
        an
    );

    input clk;
    input wire [15:0] disp_num;
    input wire [3:0] dpdot;
    output wire[7:0] segment;
    output wire[3:0] an;

    reg[3:0] digit;
    reg[7:0] digit_seg;
    reg[12:0] counter;
    reg dot;
    reg[3:0] nan;

    wire[15:0] disp_current;

    assign segment = digit_seg;
    assign disp_current = disp_num[15:0];

    initial begin
        nan = 1;
    end

    always @(posedge clk)
    begin
        counter = counter+1;
    end

    always @(posedge counter[12])
    begin
        nan = nan << 1;
        if (nan == 0)
        begin 
          nan = 1;
        end
    end

    assign an = ~nan;

    always @(*) begin
        case(nan)
            4'b0001:begin
                digit = disp_current[3:0];
                dot = dpdot[0];
            end
            4'b0010:begin
                digit = disp_current[7:4];
                dot = dpdot[1];
            end
            4'b0100:begin
                digit = disp_current[11:8];
                dot = dpdot[2];
            end
            4'b1000:begin
                digit = disp_current[15:12];
                dot = dpdot[3];
            end
        endcase
    end

    always @(*)begin
        case(digit)
            0: digit_seg = 7'b1000000;
            1: digit_seg = 7'b1111001;
            2: digit_seg = 7'b0100100;
            3: digit_seg = 7'b0110000;
            4: digit_seg = 7'b0011001;
            5: digit_seg = 7'b0010010;
            6: digit_seg = 7'b0000010;
            7: digit_seg = 7'b1111000;
            8: digit_seg = 7'b0000000;
            9: digit_seg = 7'b0010000;
            'hA: digit_seg = 7'b0001000;
            'hB: digit_seg = 7'b0000011;
            'hC: digit_seg = 7'b1000110;
            'hD: digit_seg = 7'b0100001;
            'hE: digit_seg = 7'b0000110;
            'hF: digit_seg = 7'b0001110;
            default: digit_seg = 7'b1000000;
        endcase
        digit_seg[7] = dot;
    end

endmodule

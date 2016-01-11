module mapPac(
    clk,
    x,
    y,
    direction,
    pixel
);

input clk;
input [4:0] x,y;
input [3:0] direction;

output reg pixel;

reg [23: 0] counter;
reg flag;


localparam L = 4'b1000;
localparam U = 4'b0100;
localparam R = 4'b0010;
localparam D = 4'b0001;



localparam PAC_LEFT = {
    12'b000001100000,
    12'b001111111100,
    12'b011111111110,
    12'b111111111111,
    12'b111111100000,
    12'b111111000000,
    12'b111111100000,
    12'b111111110000,
    12'b111111111111,
    12'b011111111110,
    12'b001111111100,
    12'b000001100000
    };

    localparam PAC_RIGHT = {
        12'b000001100000,
        12'b001111111100,
        12'b011111111110,
        12'b011111111111,
        12'b000001111111,
        12'b000000111111,
        12'b000001111111,
        12'b000011111111,
        12'b011111111111,
        12'b011111111110,
        12'b001111111100,
        12'b000001100000
        };

    localparam PAC_DOWN = {
        12'b000000000000,
        12'b000000000000,
        12'b011000000110,
        12'b111100001111,
        12'b111100001111,
        12'b111110011111,
        12'b111111111111,
        12'b111111111111,
        12'b111111111111,
        12'b011111111110,
        12'b001111111100,
        12'b000000000000
        };

    localparam PAC_UP= {
        12'b000111110000,
        12'b011111111100,
        12'b011111111110,
        12'b111111111111,
        12'b111111111111,
        12'b111111111111,
        12'b111110011111,
        12'b111110011111,
        12'b111100001111,
        12'b011000000110,
        12'b000000000000,
        12'b000000000000
    };
    localparam PAC_DEFAULT = {
        12'b000111110000,
        12'b011111111100,
        12'b011111111110,
        12'b111111111111,
        12'b111111111111,
        12'b111111111111,
        12'b111111111111,
        12'b111111111111,
        12'b111111111111,
        12'b011111111110,
        12'b001111111000,
        12'b000011100000
    };

    initial begin
        counter = 0;
        flag = 0;
    end

    always @(posedge clk)
    begin
        if (counter == 10000000)
        begin
            counter <= 0;
            flag <= ~flag;
        end
        else
            counter <= counter + 1;
    end

    always @(posedge clk)
    begin
        case (direction)
            L:
            begin
                if (flag)
                    pixel <= PAC_LEFT[(y / 2) * 12 + (x / 2)];
                else
                    pixel <= PAC_DEFAULT[(y/2) * 12 + (x/2)];
            end
            U:
            begin
                if (flag)
                    pixel <= PAC_UP[(y / 2) * 12 + (x / 2)];
                else
                    pixel <= PAC_DEFAULT[(y/2) * 12 + (x/2)];
            end
            R:
            begin
                if (flag)
                    pixel <= PAC_RIGHT[(y / 2) * 12 + (x / 2)];
                else
                    pixel <= PAC_DEFAULT[(y/2) * 12 + (x/2)];
            end
            D:
            begin
                if (flag)
                    pixel <= PAC_DOWN[(y / 2) * 12 + (x / 2)];
                else
                    pixel <= PAC_DEFAULT[(y/2) * 12 + (x/2)];
            end
            default: 
            begin
                pixel <= PAC_DEFAULT[(y/2) * 12 + (x/2)];
            end
        endcase
    end

endmodule


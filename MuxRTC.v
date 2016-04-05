`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:22:02 04/05/2016 
// Design Name: 
// Module Name:    MuxRTC 
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
module MuxRTC(
    input [11:0]control1,
    input [11:0]control2,
    input [11:0]control3,
    input [11:0]control4,
	 input [11:0]control5,
	 input [11:0]control6,
	 input [2:0]seleccion,
    output reg ad,
    output reg rd,
    output reg cs,
    output reg wr,
    output reg [7:0] ADout
    );
always @*
	begin
	case(seleccion)
	3'b000:begin
			 ad<=control1[11];
			 rd<=control1[10];
			 cs<=control1[9];
			 wr<=control1[8];
			 ADout<=control1[7:0];
			 end
	3'b001:begin
			 ad<=control2[11];
			 rd<=control2[10];
			 cs<=control2[9];
			 wr<=control2[8];
			 ADout<=control2[7:0];
			 end
	3'b010:begin
			 ad<=control3[11];
			 rd<=control3[10];
			 cs<=control3[9];
			 wr<=control3[8];
			 ADout<=control3[7:0];
			 end
	3'b011:begin
			 ad<=control4[11];
			 rd<=control4[10];
			 cs<=control4[9];
			 wr<=control4[8];
			 ADout<=control4[7:0];
			 end
	3'b100:begin
			 ad<=control5[11];
			 rd<=control5[10];
			 cs<=control5[9];
			 wr<=control5[8];
			 ADout<=control5[7:0];
			 end
	3'b101:begin
			 ad<=control6[11];
			 rd<=control6[10];
			 cs<=control6[9];
			 wr<=control6[8];
			 ADout<=control6[7:0];
			 end
			default :begin
						ad<=control1[11];
						rd<=control1[10];
						cs<=control1[9];
						wr<=control1[8];
						ADout<=control1[7:0];
						end
	endcase
	end
endmodule

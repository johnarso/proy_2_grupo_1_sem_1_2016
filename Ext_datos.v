`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:08:28 03/23/2016 
// Design Name: 
// Module Name:    Ext_datos 
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
module Ext_datos(
    input [7:0] ADin,
	 input clock,
	 input reset,
	 input chs,
	 output reg [7:0] ADout,
    output reg ad,
    output reg wr,
    output reg rd,
    output reg cs,
	 output reg [7:0]hora,
	 output reg [7:0]min,
	 output reg [7:0]seg,
	 output reg [7:0]dia,
	 output reg [7:0]mes,
	 output reg [7:0]year,
	 output reg [7:0]horacrono,
	 output reg [7:0]mincrono,
	 output reg [7:0]segcrono,
	 output reg AmPm,
	 output reg timer
    );
reg [5:0]cont;
reg [3:0]contadd;
reg [7:0]dir;
reg chsref;

always @(posedge clock)
begin
	if (reset)
	begin
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	cs<=1'h1;
	ADout<=8'hff;
	cont<=0;
	AmPm<=0;
	contadd<=0;
	hora<=8'b10000000;
	min<=0;
	seg<=0;
	dia<=0;
	mes<=0;
	year<=0;
	horacrono<=0;
	mincrono<=0;
	segcrono<=0;
	chsref<=0;
	timer<=0;
	dir<=8'hff;
	
	end
	else if (chs>chsref) chsref<=chs;
	else if (chsref) 
	begin
	if (cont==0)
	begin
	case (contadd)
		4'b0000:dir<=8'hf0;
		4'b0001:dir<=8'h26;
		4'b0010:dir<=8'h25;
		4'b0011:dir<=8'h24;
		4'b0100:dir<=8'h23;
		4'b0101:dir<=8'h22;
		4'b0110:dir<=8'h21;
		4'b0111:dir<=8'h43;
		4'b1000:dir<=8'h42;
		4'b1001:dir<=8'h41;
		4'b1010:dir<=8'h01;
		default dir<=8'hf0;
	endcase
	ad<=1;
	wr<=1;
	rd<=1;
	cs<=1;
	cont<=cont+1'b1;
	end
		
	else if (cont==1)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==2)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==3)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==4)
		begin
		ADout<=dir;
		cont<=cont+1'b1;
		end
	else if (cont==9)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==10)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==11)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==13)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==21)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==22)
		begin
		rd<=0;
		cont<=cont+1'b1;
		end
	else if (cont==27)
		begin
		case (contadd)
		4'b0001:year<=ADin;
		4'b0010:mes<=ADin;
		4'b0011:dia<=ADin;
		4'b0100:begin
					hora[6:0]<=ADin[6:0];
					AmPm<=ADin[7];
					hora[7]<=0;
					end
		4'b0101:min<=ADin;
		4'b0110:seg<=ADin;
		4'b0111:horacrono<=ADin;
		4'b1000:mincrono<=ADin;
		4'b1001:segcrono<=ADin;
		4'b1010:timer<=ADin[6];
		default ADout<=ADin;
		endcase
		cont<=cont+1'b1;
		end
	else if (cont==28)
		begin
		rd<=1;
		cont<=cont+1'b1;
		end
	else if (cont==29)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==39)
		begin
		cont<=0;
		contadd<=contadd+1'b1;
		end
	else cont<=cont+1'b1;
	
	if (contadd==11)
		begin
		contadd<=0;
		cont<=0;
		chsref<=0;
		end
	
	end
	else
	begin
	ADout<=8'hff;
	cs<=1'h1;
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	cont<=0;
	contadd<=0;
	end
end
endmodule

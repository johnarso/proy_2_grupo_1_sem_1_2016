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
	 output reg [7:0]segcrono
    );
reg [5:0]cont;
reg [3:0]contadd;
reg [7:0]dir;
reg chsref;

always @(posedge clock)
begin
	if (reset)
	begin
	ad<=1'hz;
	wr<=1'hz;
	rd<=1'hz;
	cs<=1'hz;
	ADout<=8'hzz;
	cont<=0;
	contadd<=0;
	hora<=0;
	min<=0;
	seg<=0;
	dia<=0;
	mes<=0;
	year<=0;
	horacrono<=0;
	mincrono<=0;
	segcrono<=0;
	chsref<=0;
	
	end
	else if (chs>chsref) chsref<=chs;
	else if (chsref) 
	begin
	if (cont==0)
	begin
	case (contadd)
		4'b0000:dir<=8'h26;
		4'b0001:dir<=8'h25;
		4'b0010:dir<=8'h24;
		4'b0011:dir<=8'h23;
		4'b0100:dir<=8'h22;
		4'b0101:dir<=8'h21;
		4'b0110:dir<=8'h43;
		4'b0111:dir<=8'h42;
		4'b1000:dir<=8'h41;
		default dir<=8'h26;
	endcase
	ad<=1;
	wr<=1;
	rd<=1;
	cs<=1;
	cont<=cont+1;
	end
		
	else if (cont==1)
	begin
		ad<=0;
		cont<=cont+1;
	end
	else if(cont==2)
		begin
		cs<=0;
		cont<=cont+1;
		end
	else if (cont==3)
		begin
		wr<=0;
		cont<=cont+1;
		end
	else if (cont==5)
		begin
		ADout<=dir;
		cont<=cont+1;
		end
	else if (cont==8)
		begin
		wr<=1;
		cont<=cont+1;
		end
	else if (cont==9)
		begin
		cs<=1;
		cont<=cont+1;
		end
	else if (cont==10)
		begin
		ad<=1;
		cont<=cont+1;
		end
	else if (cont==12)
		begin
		ADout<=8'hzz;
		cont<=cont+1;
		end
	else if (cont==15)
		begin
		cs<=0;
		cont<=cont+1;
		end
	else if (cont==16)
		begin
		rd<=0;
		cont<=cont+1;
		end
	else if (cont==18)
		begin
		case (contadd)
		4'b0000:year<=ADin;
		4'b0001:mes<=ADin;
		4'b0010:dia<=ADin;
		4'b0011:hora<=ADin;
		4'b0100:min<=ADin;
		4'b0101:seg<=ADin;
		4'b0110:horacrono<=ADin;
		4'b0111:mincrono<=ADin;
		4'b1000:segcrono<=ADin;
		default year<=ADin;
		endcase
		cont<=cont+1;
		end
	else if (cont==21)
		begin
		rd<=1;
		cont<=cont+1;
		end
	else if (cont==22)
		begin
		cs<=1;
		cont<=cont+1;
		end
	else if (cont==32)
		begin
		cont<=0;
		contadd<=contadd+1;
		end
	else cont=cont+1;
	
	if (contadd==9)
		begin
		contadd<=0;
		cont<=0;
		chsref<=0;
		end
	
	end
	else
	begin
	ADout<=8'hzz;
	cs<=1'hz;
	ad<=1'hz;
	wr<=1'hz;
	rd<=1'hz;
	cont<=0;
	contadd<=0;
	end
end
endmodule

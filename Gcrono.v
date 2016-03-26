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
module Gcrono(
    input [7:0] horac,
	 input [7:0] minc,
	 input [7:0] segc,
	 input clock,
	 input reset,
	 input chs,
	 output reg [7:0] ADout,
    output reg ad,
    output reg wr,
    output reg rd,
    output reg cs
	 
    );
reg [6:0]cont;
reg [1:0]contadd;
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
	chsref<=0;	
	end
	
	else if (chs>chsref) chsref<=chs;
	
	else if (chsref) 
	begin
	if (cont==0)
	begin
	case (contadd)
		2'b00:dir<=8'h43;
		2'b01:dir<=8'h42;
		2'b10:dir<=8'h41; 
		default dir<=8'h43;
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
	else if (cont==4)
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
	else if (cont==11)
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
		wr<=0;
		cont<=cont+1;
		end
	else if (cont==18)
		begin
		case (contadd)
		2'b00:ADout<=horac;
		2'b01:ADout<=minc;
		2'b10:ADout<=segc;
		default ADout<=horac;
		endcase
		cont<=cont+1;
		end
	else if (cont==21)
		begin
		wr<=1;
		cont<=cont+1;
		end
	else if (cont==22)
		begin
		cs<=1;
		cont<=cont+1;
		end
	else if (cont==24)
		begin
		ADout<=8'hzz;
		cont<=cont+1;
		end
	else if (cont==34)
		begin
		cont<=0;
		contadd<=contadd+1;
		end
	else cont=cont+1;
	
	if (contadd==3)
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
	end
	
end
endmodule

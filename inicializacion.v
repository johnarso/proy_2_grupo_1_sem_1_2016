`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:27 03/26/2016 
// Design Name: 
// Module Name:    inicializacion 
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
module inicializacion(
    input clock,
    input reset,
    output reg cs,
    output reg ad,
    output reg rd,
    output reg wr,
    output reg [7:0] ADout
    );
reg resetref;
reg [7:0]cont;



always @(posedge clock)
begin
	if (resetref)
	begin
	if (cont==0)
	begin
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
		ADout<=8'h02;
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
	else if (cont==22)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==23)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==24)
		begin
		ADout[0]<=0;
		ADout[1]<=0;
		ADout[2]<=0;
		ADout[3]<=0;
		ADout[4]<=1;
		ADout[5]<=0;
		ADout[6]<=0;
		ADout[7]<=0;
		cont<=cont+1'b1;
		end
	else if (cont==29)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==30)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==32)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	
	else if (cont==41)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==42)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==43)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==44)
		begin
		ADout<=8'h02;
		cont<=cont+1'b1;
		end
	else if (cont==49)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==50)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==51)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==53)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==64)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==65)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==66)
		begin
		ADout<=0;
		cont<=cont+1'b1;
		end
	else if (cont==71)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==72)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==74)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==81)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==82)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==83)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==84)
		begin
		ADout<=8'h10;
		cont<=cont+1'b1;
		end
	else if (cont==89)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==90)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==91)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==93)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==104)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==105)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==106)
		begin
		ADout<=8'hd2;
		cont<=cont+1'b1;
		end
	else if (cont==111)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==112)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==114)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==123)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==124)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==125)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==126)
		begin
		ADout<=8'h00;
		cont<=cont+1'b1;
		end
	else if (cont==131)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==132)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==133)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==135)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==144)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==145)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==146)
		begin
		ADout<=8'h00;
		cont<=cont+1'b1;
		end
	else if (cont==151)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==152)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	
	else if (cont==155)
		begin
		if (reset==0)resetref<=0;
		ADout<=8'hff;
		ad<=1'h1;
		wr<=1'h1;
		rd<=1'h1;
		cs<=1'h1;
		end
	else cont<=cont+1'b1;
	
	end
	else if (reset==1)
	begin
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	cs<=1'h1;
	ADout<=8'hff;
	cont<=0;
	resetref<=1;
	end
	
	else
	begin
	ADout<=8'hff;
	cs<=1'h1;
	ad<=1'h1;
	wr<=1'h1;
	rd<=1'h1;
	end
	
end

endmodule

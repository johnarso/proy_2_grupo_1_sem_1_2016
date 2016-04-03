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
	else if (cont==21)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==22)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==23)
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
	else if (cont==28)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==29)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==31)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	
	else if (cont==39)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==40)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==41)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==42)
		begin
		ADout<=8'h02;
		cont<=cont+1'b1;
		end
	else if (cont==47)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==48)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==49)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==51)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==59)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==60)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==61)
		begin
		ADout<=0;
		cont<=cont+1'b1;
		end
	else if (cont==66)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==67)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==69)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==77)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==78)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==79)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==80)
		begin
		ADout<=8'h10;
		cont<=cont+1'b1;
		end
	else if (cont==85)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==86)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==87)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==89)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==97)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==98)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==99)
		begin
		ADout<=8'hd2;
		cont<=cont+1'b1;
		end
	else if (cont==104)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==105)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==107)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==115)
	begin
		ad<=0;
		cont<=cont+1'b1;
	end
	else if(cont==116)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==117)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==118)
		begin
		ADout<=8'h00;
		cont<=cont+1'b1;
		end
	else if (cont==123)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==124)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	else if (cont==125)
		begin
		ad<=1;
		cont<=cont+1'b1;
		end
	else if (cont==127)
		begin
		ADout<=8'hff;
		cont<=cont+1'b1;
		end
	else if (cont==135)
		begin
		cs<=0;
		cont<=cont+1'b1;
		end
	else if (cont==136)
		begin
		wr<=0;
		cont<=cont+1'b1;
		end
	else if (cont==137)
		begin
		ADout<=8'h00;
		cont<=cont+1'b1;
		end
	else if (cont==142)
		begin
		wr<=1;
		cont<=cont+1'b1;
		end
	else if (cont==143)
		begin
		cs<=1;
		cont<=cont+1'b1;
		end
	
	else if (cont==145)
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

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
reg [6:0]cont;
reg [7:0]dir;


always @(posedge clock)
begin
	if (resetref)
	begin
	if (cont==0)
	begin
	dir<=8'h02;
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
		ADout[0]<=0;
		ADout[1]<=0;
		ADout[2]<=0;
		ADout[3]<=0;
		ADout[4]<=1;
		ADout[5]<=0;
		ADout[6]<=0;
		ADout[7]<=0;
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
		if (reset==0)resetref<=0;
		ADout<=8'hzz;
		ad<=1'hz;
		wr<=1'hz;
		rd<=1'hz;
		cs<=1'hz;
		end
	else cont=cont+1;
	
	end
	else if (reset==1)
	begin
	ad<=1'hz;
	wr<=1'hz;
	rd<=1'hz;
	cs<=1'hz;
	ADout<=8'hzz;
	cont<=0;
	resetref<=1;
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

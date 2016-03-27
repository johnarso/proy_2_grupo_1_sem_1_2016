`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:22 03/26/2016 
// Design Name: 
// Module Name:    inicrono 
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
module chcronoformatlock(
    input clock,
    input reset,
	 input enc,
	 input enf,
	 input enl,
	 input inic,
	 input format,
	 input lock,
    output reg ad,
    output reg wr,
    output reg cs,
    output reg rd,
    output reg [7:0] ADout
    );
reg [6:0]cont;
reg [7:0]dir;
reg encrono;
reg enformat;
reg enlock;
reg encr;
reg enfor;
reg enlo;
always @(posedge clock)
begin
	if (reset)
	begin
	ad<=1'hz;
	wr<=1'hz;
	rd<=1'hz;
	cs<=1'hz;
	encrono<=0;
	enformat<=0;
	enlock<=0;
	encr<=0;
	enfor<=0;
	enlo<=0;
	ADout<=8'hzz;
	cont<=0;
	end

	else if (encrono<enc||enformat<enf||enlock<enl||encrono<encr||enformat<enfor||enlock<enlo)
	begin
	if (cont==0)
	begin
	dir<=8'h00;
	ad<=1;
	wr<=1;
	rd<=1;
	cs<=1;
	encr<=enc;
	enfor<=enf;
	enlo<=enl;
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
		ADout[3]<=inic;
		ADout[4]<=format;
		ADout[5]<=lock;
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
		encrono<=enc;
		enformat<=enf;
		enlock<=enl;
		cont<=0;
		encr<=0;
		enfor<=0;
		enlo<=0;
		ADout<=8'hzz;
		ad<=1'hz;
		wr<=1'hz;
		rd<=1'hz;
		cs<=1'hz;
		end
	else cont<=cont+1;
	
	end
	else if (encrono>enc)encrono<=0;
	else if (enformat>enf)enformat<=0;
	else if (enlock<enl)enlock<=0;
	
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

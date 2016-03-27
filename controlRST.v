`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:44:37 03/26/2016 
// Design Name: 
// Module Name:    controlRST 
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
module controlRST(
    input SWhora,
    input SWfecha,
    input SWcrono,
	 input SWiniC,
	 input SWf,
	 input up,
	 input dwn,
	 input lf,
	 input rg,
	 input rst,
	 input clk,
	 inout [7:0]AD,
	 output ad,
	 output wr,
	 output cs,
	 output rd,
    output reg hora,
	 output reg min,
	 output reg seg,
	 output reg AMPM,
	 output reg d,
	 output reg me,
	 output reg y,
	 output reg horacr,
	 output reg mincr,
	 output reg segcr,
	 output tim
    );
wire ENch,ENcf,ENcc,ENgh,ENgf,ENgc,ENed,ENcfor,ENci,ENlo,lck;
wire h,m,s,dia,mes,year,hcr,mcr,scr,ap;
wire Hcc,Mcc,Scc;
wire Hc,Mc,Sc,ampm;
wire dc,mc,yc;
wire arriba,abajo,izq,der,fmt,ph,pf,pc,ic;

inicializacion instini(.clock(clk),.reset(rst),.cs(cs),.ad(ad),.rd(rd),.wr(wr),.ADout(AD) );

chcronoformatlock instchcrfolo(.clock(clk),.reset(rst),.enc(ENci), //MODIFICAR MODULO
										.enf(ENcfor),.enl(ENlo),.inic(SWiniC),.format(SWf),.lock(lck),
										.ad(ad),.wr(wr),.cs(cs),
										.rd(rd),.ADout(AD) );

FFs instFFs(.aumentar(up),.disminuir(dwn),.left(lf),.right(rg),.format(SWf),
				.ph(SWhora),.pf(SWfecha),.pc(SWcrono),.ic(SWiniC),.clk(clk),.reset(rst),.au(arriba),.dis(abajo),.l(izq),
				.r(der),.f(fmt),.prh(ph),.prf(pf),.prc(pc),.icr(ic) );

control instcontrol(.clock(clk),.reset(rst),.Phora(ph),.Pfecha(pf),.Pcrono(pc),
							.cronoini(SWiniC),.format(SWf),
						.ENchora(ENch),.ENcfecha(ENcf),.ENccrono(ENcc),.ENghora(ENgh),
						.ENgfecha(ENgf),.ENgcrono(ENgc),.ENedatos(ENed),
						.ENcformat(ENcfor),.ENcinic(ENci),.ENlock(ENlo),.lock(lck)	);

Ext_datos instExt_datos(.ADin(AD),.clock(clk),.reset(rst),.chs(ENed),
								.ADout(AD),.ad(ad),.wr(wr),.rd(rd),.cs(cs),.hora(h),.min(m),
								.seg(s),.dia(dia),.mes(mes),.year(year),.horacrono(hcr),.mincrono(mcr),
								.segcrono(scr),.AmPm(ap),.timer(tim) );

CCrono instCCrono(.Hcr(hcr),.Mcr(mcr),.Scr(scr),.EN(ENcc),.BTup(arriba),.BTdown(abajo),
						.BTl(izq),.BTr(der),.clk(clk),.reset(rst),.HCcr(Hcc),.MCcr(Mcc),
						.SCcr(Scc) );
						
CFecha instCFecha(.dia(dia),.mes(mes),.year(year),.EN(ENcf),.BTup(arriba),.BTdown(abajo),
						.BTl(izq),.BTr(der),.clk(clk),.reset(rst),.diaC(dc),.mesC(mc),
						.yearC(yc) );

CHora instCHora(.H(h),.M(m),.S(s),.ampm(ap),.format(fmt),.EN(ENch),.BTup(arriba),.BTdown(abajo), 
					.BTl(izq),.BTr(der),.clk(clk),.reset(rst),.HC(Hc),.MC(Mc),.SC(Sc),.AmPm(ampm));

Gcrono instGcrono(.horac(Hcc),.minc(Mcc),.segc(Scc),.clock(clk),.reset(rst),.chs(ENgc),
					.ADout(AD),.ad(ad),.wr(wr),.rd(rd),.cs(cs) );
					
Gfecha instGfecha(.dia(dc),.mes(mc),.year(yc),.clock(clk),.reset(rst),.chs(ENgf),
			.ADout(AD),.ad(ad),.wr(wr),.rd(rd),.cs(cs) );

Ghora instGhora(.hora(Hc),.min(Mc),.seg(Sc),.AmPm(ampm),.clock(clk),.reset(rst),.chs(ENgh),
						.ADout(AD),.ad(ad),.wr(cs),.rd(rd),.cs(cs) );
always @(posedge clk)
begin
if (rst)
begin
	hora<=0;
	min<=0;
	seg<=0;
	AMPM<=0;
	d<=0;
	me<=0;
	y<=0;
	horacr<=0;
	mincr<=0;
	segcr<=0;
end
else
begin
	if (ph==1)
	begin
		hora<=Hc;
		min<=Mc;
		seg<=Sc;
		AMPM<=ampm;
		d<=dia;
		me<=mes;
		y<=year;
		horacr<=hcr;
		mincr<=mcr;
		segcr<=scr;
	end
	else if (pf==1)
	begin
		hora<=h;
		min<=m;
		seg<=s;
		AMPM<=ap;
		d<=dc;
		me<=mc;
		y<=yc;
		horacr<=hcr;
		mincr<=mcr;
		segcr<=scr;
	end
	else if (pc==1)
	begin
		hora<=h;
		min<=m;
		seg<=s;
		AMPM<=ap;
		d<=dia;
		me<=mes;
		y<=year;
		horacr<=Hcc;
		mincr<=Mcc;
		segcr<=Scc;
	end
	else
	begin
		hora<=h;
		min<=m;
		seg<=s;
		AMPM<=ap;
		d<=dia;
		me<=mes;
		y<=year;
		horacr<=hcr;
		mincr<=mcr;
		segcr<=scr;
	end
end
end
endmodule

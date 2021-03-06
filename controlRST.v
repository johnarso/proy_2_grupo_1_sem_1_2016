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
module controlRTC(
    input SWhora,SWfecha,SWcrono,SWiniC,SWf,up,dwn,lf,rg,rst,clk,
	 input [7:0]ADin,
	 output [7:0]ADout,
	 output ad,wr,cs,rd,AMPM, 
    output [7:0]hora,min,seg,d,me,y,horacr,mincr,segcr,horapr,minpr,segpr,
	 output [2:0]cursgcrono,cursghora,cursgfecha,
	 output [1:0]Smuxdt,
	 output Pullup,tim,
	 output formato,
	 output handS
    );
wire ENch,ENcf,ENcc,ENgh,ENgf,ENgc,ENed,ENci,ENcomp,lck;
wire ap1,ap2;
wire arriba,abajo,izq,der,fmt,ph,pf,pc,ic;
wire [11:0]ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6;
wire [23:0]dt11,dt12,dt21,dt22;
wire final;
wire [2:0]Smuxctr;

inicializacion instini(.clock(clk),.reset(rst),.cs(ctrl1[9]),.ad(ctrl1[11]),.rd(ctrl1[10]),.wr(ctrl1[8]),.ADout(ctrl1[7:0]) );

chcronoformatlock instchcrfolo(.clock(clk),.reset(rst),.enc(ENci), 
										.inic(SWiniC),.format(SWf),.lock(lck),.fin(final),
										.ad(ctrl2[11]),.wr(ctrl2[8]),.cs(ctrl2[9]),
										.rd(ctrl2[10]),.ADout(ctrl2[7:0]) );

FFs instFFs(.aumentar(up),.disminuir(dwn),.left(lf),.right(rg),.format(SWf),
				.ph(SWhora),.pf(SWfecha),.pc(SWcrono),.ic(SWiniC),.clk(clk),.reset(rst),.au(arriba),.dis(abajo),.l(izq),
				.r(der),.f(fmt),.prh(ph),.prf(pf),.prc(pc),.icr(ic) );

control instcontrol(.fin(final),.clock(clk),.reset(rst),.Phora(ph),.Pfecha(pf),.Pcrono(pc),
							.cronoini(ic),.format(fmt),
						.ENchora(ENch),.ENcfecha(ENcf),.ENccrono(ENcc),.ENghora(ENgh),
						.ENgfecha(ENgf),.ENgcrono(ENgc),.ENedatos(ENed),
						.ENcinic(ENci),.ENcompa(ENcomp),.lock(lck),.selmuxdt(Smuxdt),.selmuxctr(Smuxctr),.hs(handS)	);

Ext_datos instExt_datos(.ADin(ADin),.clock(clk),.reset(rst),.chs(ENed),.format(fmt),
								.ADout(ctrl3[7:0]),.ad(ctrl3[11]),.wr(ctrl3[8]),.rd(ctrl3[10]),.cs(ctrl3[9]),.hora(dt11[23:16]),.min(dt11[15:8]),
								.seg(dt11[7:0]),.dia(dt12[23:16]),.mes(dt12[15:8]),.year(dt12[7:0]),.horacrono(horacr),.mincrono(mincr),
								.segcrono(segcr),.AmPm(ap1),.Pup(Pullup) );

CCrono instCCrono(.EN(ENcc),.BTup(arriba),.BTdown(abajo),
						.BTl(izq),.BTr(der),.clk(clk),.reset(rst),.HCcr(horapr),.MCcr(minpr),
						.SCcr(segpr),.contador(cursgcrono) );
						
CFecha instCFecha(.dia(dt12[23:16]),.mes(dt12[15:8]),.year(dt12[7:0]),.EN(ENcf),.BTup(arriba),.BTdown(abajo),
						.BTl(izq),.BTr(der),.clk(clk),.reset(rst),.diaC(dt22[23:16]),.mesC(dt22[15:8]),
						.yearC(dt22[7:0]),.contador(cursgfecha) );

CHora instCHora(.H(dt11[23:16]),.M(dt11[15:8]),.S(dt11[7:0]),.ampm(ap1),.format(fmt),.EN(ENch),.BTup(arriba),.BTdown(abajo), 
					.BTl(izq),.BTr(der),.clk(clk),.reset(rst),.HC(dt21[23:16]),.MC(dt21[15:8]),.SC(dt21[7:0]),.AmPm(ap2),.contador(cursghora));

Gcrono instGcrono(.clock(clk),.reset(rst),.chs(ENgc),
					.ADout(ctrl6[7:0]),.ad(ctrl6[11]),.wr(ctrl6[8]),.rd(ctrl6[10]),.cs(ctrl6[9]) );
					
Gfecha instGfecha(.swcr(ic),.form(fmt),.dia(dt22[23:16]),.mes(dt22[15:8]),.year(dt22[7:0]),.clock(clk),.reset(rst),.chs(ENgf),
			.ADout(ctrl5[7:0]),.ad(ctrl5[11]),.wr(ctrl5[8]),.rd(ctrl5[10]),.cs(ctrl5[9]) );

Ghora instGhora(.swcr(ic),.form(fmt),.hora(dt21[22:16]),.min(dt21[15:8]),.seg(dt21[7:0]),.AmPm(ap2),.clock(clk),.reset(rst),.chs(ENgh),
						.ADout(ctrl4[7:0]),.ad(ctrl4[11]),.wr(ctrl4[8]),.rd(ctrl4[10]),.cs(ctrl4[9]) );

MuxRTC instMuxrtc(.control1(ctrl1),.control2(ctrl2),.control3(ctrl3),.control4(ctrl4),
						.control5(ctrl5),.control6(ctrl6),.seleccion(Smuxctr),.ad(ad),
						.rd(rd),.cs(cs),.wr(wr),.ADout(ADout) );

Muxdatos instMuxdatos(.datos11(dt11),.datos12(dt12),.datos21(dt21),.datos22(dt22),.ap1(ap1),.ap2(ap2),
							 .seleccion(Smuxdt),.hora(hora),.min(min),.seg(seg),.dia(d),.mes(me),.year(y),.ampm(AMPM));

ComparadorC instCompC(.CprogH(horapr),.CprogM(minpr),.CprogS(segpr),.CcountH(horacr),
							 .CcountM(mincr),.CcountS(segcr),.en(ENcomp),.reset(rst),.clock(clk),.fin(final) );

assign tim=final;
assign formato=fmt;

endmodule

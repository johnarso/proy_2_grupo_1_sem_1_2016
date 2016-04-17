`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:28 04/08/2016 
// Design Name: 
// Module Name:    Sistema 
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
module Sistema(
    input CLOCK_NEXYS,
	 input [5:0] switch, 		//sw[5]: reset
	 input [3:0] botones,
	 input [7:0] AD_IN,
	 output [7:0] AD_OUT,
	 output [11:0] COLORES,
	 output H_syncro, V_syncro, 
	 output R_D, C_S, W_R, A_D, 
	 output [4:0] LED
	 );
	 
	 
	 wire [7:0] reloj_hora, reloj_minuto, reloj_segundo, fecha_dia, fecha_mes, fecha_anio;
	 wire [7:0] pr_hora, pr_minuto, pr_segundo, crono_hora, crono_minuto, crono_segundo;
	 wire final_cronom, am_pm_bandera, formato_hora;
	 
	 wire [1:0] lugar_program;
	 wire [2:0] cursor_crono, cursor_fecha, cursor_hora;
	 wire PUP;
	 wire [7:0]ADOUT;
	 wire r_lent;
	 wire HS;
	 wire [4:0] Int_LED;
	 
	Interfaz_leds inst_LEDS(
	.reset(switch[5]), .clk(CLOCK_NEXYS),
	.leds(Int_LED)
    );
	 
	VGA controlador_vga(
	.reloj_nexys(CLOCK_NEXYS), .reset_total(switch[5]),
	.direc_prog(lugar_program),
	.prog_crono(cursor_crono), .prog_fecha(cursor_fecha), .prog_hora(cursor_hora),
	.finale(final_cronom), .tempo(am_pm_bandera), .formatto(formato_hora), .handshake(HS),
	.h_oro_act(reloj_hora), .m_oro_act(reloj_minuto), .s_oro_act(reloj_segundo), 
	.giorno_act(fecha_dia), .messe_act(fecha_mes), .agno_act(fecha_anio),
	.ora_act(pr_hora), .minute_act(pr_minuto), .secondo_act(pr_segundo), 
	.h_run_act(crono_hora), .m_run_act(crono_minuto), .s_run_act(crono_segundo),
	.color_salida(COLORES),
	.hsincro(H_syncro), .vsincro(V_syncro)
    );
	 
	 controlRTC controlador_rtc(
    .SWhora(switch[4]),.SWfecha(switch[3]),.SWcrono(switch[2]),.SWiniC(switch[1]),.SWf(switch[0]),
	 .up(botones[3]),.dwn(botones[2]),.lf(botones[1]),.rg(botones[0]),.rst(switch[5]),.clk(CLOCK_NEXYS),
	 .ADin(AD_IN),.ADout(ADOUT),
	 .ad(A_D),.wr(W_R),.cs(C_S),.rd(R_D),
	 .AMPM(am_pm_bandera),
    .hora(reloj_hora),.min(reloj_minuto),.seg(reloj_segundo),.d(fecha_dia),.me(fecha_mes),.y(fecha_anio),
	 .horacr(crono_hora),.mincr(crono_minuto),.segcr(crono_segundo),.horapr(pr_hora),.minpr(pr_minuto),.segpr(pr_segundo),
	 .cursgcrono(cursor_crono),.cursghora(cursor_hora),.cursgfecha(cursor_fecha),
	 .Smuxdt(lugar_program),
	 .tim(final_cronom),
	 .Pullup(PUP),
	 .formato(formato_hora),
	 .handS(HS)
    );

assign AD_OUT = (~PUP) ? ADOUT : 8'hzz;
assign LED=Int_LED;
endmodule

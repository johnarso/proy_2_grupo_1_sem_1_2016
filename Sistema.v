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
	 output terminal
	 );
	 
	 
	 wire [7:0] reloj_hora, reloj_minuto, reloj_segundo, fecha_dia, fecha_mes, fecha_anio;
	 wire [7:0] pr_hora, pr_minuto, pr_segundo, crono_hora, crono_minuto, crono_segundo;
	 wire final_cronom, am_pm_bandera, formato_hora;
	 
	 wire [1:0] lugar_program;
	 wire [2:0] cursor_crono, cursor_fecha, cursor_hora;
	 wire PUP;
	 wire [7:0]ADOUT;
	 wire r_lent;
	 
	VGA controlador_vga(
	.relojsito(CLOCK_NEXYS), .resetito(switch[5]),
	.direc_prog(lugar_program),
	.prog_crono(cursor_crono), .prog_fecha(cursor_fecha), .prog_hora(cursor_hora),
	.finale(final_cronom), .tempo(am_pm_bandera), .formaggio(formato_hora),
	.h_oro(reloj_hora), .m_oro(reloj_minuto), .s_oro(reloj_segundo), 
	.giorno(fecha_dia), .messe(fecha_mes), .agno(fecha_anio),
	.ora(pr_hora), .minute(pr_minuto), .secondo(pr_segundo), 
	.h_run(crono_hora), .m_run(crono_minuto), .s_run(crono_segundo),
	.colorsito(COLORES),
	.hsito(H_syncro), .vsito(V_syncro)
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
	 .formato(formato_hora)
    );

assign AD_OUT = (~PUP) ? ADOUT : 8'hzz;
assign terminal=CLOCK_NEXYS;
endmodule

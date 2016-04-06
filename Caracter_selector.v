`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:23:26 03/31/2016 
// Design Name: 
// Module Name:    Caracter_selector 
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
module Caracter_selector(
    input NEXYS_CLOCK,
	 input crono_end, am_pm, formato,
	 input [7:0] hora, min, seg, dia, mes, year, hcrono, mcrono, scrono, hcrono_run, mcrono_run, scrono_run,
	 input [9:0] pix_x,
	 input [9:0] pix_y,
	 output reg [11:0] color
	 );
	 
	 wire [7:0] PALABRA;
	 wire fuente_bit;
	 wire [10:0] DIR_MEMO;
	 
	 wire On_date_a, On_date_b, On_date_c;
	 wire On_hour_a, On_hour_b, On_hour_c, On_hour_d, On_hour_e, On_hour_f, On_hour_g;
	 wire On_cron_a, On_cron_b, On_cron_c, On_cron_d;
	 wire On_prog_a, On_prog_b, On_prog_c;
	 wire On_flec_u, On_flec_d, On_flec_r, On_flec_l;
	 wire On_desp;
	 wire On_null;
	 wire On_divisor_pant;
	 wire On_borde_up, On_borde_down, On_borde_left, On_borde_right;
	 wire On_corner_up_left, On_corner_down_left, On_corner_up_right, On_corner_down_right;

	 wire [2:0] db_f_a, db_f_b, db_f_c;
	 wire [2:0] db_h_a, db_h_b, db_h_c, db_h_d, db_h_e, db_h_f, db_h_g;
	 wire [2:0] db_c_a, db_c_b, db_c_c, db_c_d;
	 wire [2:0] db_p_a, db_p_b, db_p_c;
	 wire [2:0] db_d;
	 wire [2:0] db_a_u, db_a_d, db_a_r, db_a_l;
	 wire [2:0] db_d_p;
	 wire [2:0] db_b_u, db_b_d, db_b_l, db_b_r;
	 wire [2:0] db_c_u_l, db_c_d_l, db_c_u_r, db_c_d_r;
	 reg [2:0] DIR_BIT;
	 
	 wire [3:0] df_f_a, df_f_b, df_f_c;
	 wire [3:0] df_h_a, df_h_b, df_h_c, df_h_d, df_h_e, df_h_f, df_h_g;
	 wire [3:0] df_c_a, df_c_b, df_c_c, df_c_d;
	 wire [3:0] df_p_a, df_p_b, df_p_c;
	 wire [3:0] df_d;
	 wire [3:0] df_a_u, df_a_d, df_a_r, df_a_l;
	 wire [3:0] df_d_p;
	 wire [3:0] df_b_u, df_b_d, df_b_l, df_b_r;
	 wire [3:0] df_c_u_l, df_c_d_l, df_c_u_r, df_c_d_r;
	 reg [3:0] DIR_FILA;
	 
	 reg [6:0] caracter_f_a, caracter_f_b, caracter_f_c;
	 reg [6:0] caracter_h_a, caracter_h_b, caracter_h_c, caracter_h_d, caracter_h_e, caracter_h_f, caracter_h_g;
	 reg [6:0] caracter_c_a, caracter_c_b, caracter_c_c, caracter_c_d;
	 reg [6:0] caracter_p_a, caracter_p_b, caracter_p_c;
	 reg [6:0] caracter_d;
	 reg [6:0] caracter_a_u, caracter_a_d, caracter_a_r, caracter_a_l;
	 reg [6:0] CARACTER;
	 reg [6:0] caracter_d_p;
	 reg [6:0] caracter_b_u, caracter_b_d, caracter_b_l, caracter_b_r;
	 reg [6:0] caracter_c_u_l, caracter_c_d_l, caracter_c_u_r, caracter_c_d_r;
	 
	 reg [6:0] X_ap, m_on, doce_sign, veint_sign, RING, X_next;
	 
	  font_rom instancia_MEM_FUENTE(
    .clk(NEXYS_CLOCK),
    .addr(DIR_MEMO),
    .data(PALABRA)
	 );
	 
	 assign On_borde_up =(pix_y<32) && (1<=pix_x[9:4]) && (39>pix_x[9:4]);
	 assign db_b_u=pix_x[3:1]; 
	 assign df_b_u=pix_y[4:1];
	 always @*
	 begin
		caracter_b_u = 7'h14;		//?
	 end
	 
	 assign On_borde_down =(pix_y>=448) && (1<=pix_x[9:4]) && (39>pix_x[9:4]);
	 assign db_b_d=pix_x[3:1]; 
	 assign df_b_d=pix_y[4:1];
	 always @*
	 begin
		caracter_b_d = 7'h17;		//?
	 end
	 
	 assign On_borde_left =(pix_x[9:4]==0) && (pix_y<448) && (pix_y>=32);
	 assign db_b_l=pix_x[3:1]; 
	 assign df_b_l=pix_y[4:1];
	 always @*
	 begin
		caracter_b_l = 7'h13;			//
	 end
	 
	 assign On_borde_right =(pix_x[9:4]==39) && (pix_y<448) && (pix_y>=32);
	 assign db_b_r=pix_x[3:1]; 
	 assign df_b_r=pix_y[4:1];
	 always @*
	 begin
		caracter_b_r = 7'h15;			//
	 end
	 
	 assign On_corner_up_left =(pix_y<32) && (pix_x[9:4]==0);
	 assign db_c_u_l=pix_x[3:1]; 
	 assign df_c_u_l=pix_y[4:1];
	 always @*
	 begin
		caracter_c_u_l = 7'h0f;		//?
	 end
	 
	 assign On_corner_down_left =(pix_y>=448) && (pix_x[9:4]==0);
	 assign db_c_d_l=pix_x[3:1]; 
	 assign df_c_d_l=pix_y[4:1];
	 always @*
	 begin
		caracter_c_d_l = 7'h12;		//?
	 end
	 
	 assign On_corner_up_right =(pix_y<32) && (pix_x[9:4]==39);
	 assign db_c_u_r=pix_x[3:1]; 
	 assign df_c_u_r=pix_y[4:1];
	 always @*
	 begin
		caracter_c_u_r = 7'h10;		//?
	 end
	 
	 assign On_corner_down_right =(pix_y>=448) && (pix_x[9:4]==39);
	 assign db_c_d_r=pix_x[3:1]; 
	 assign df_c_d_r=pix_y[4:1];
	 always @*
	 begin
		caracter_c_d_r = 7'h11;		//?
	 end
	 
	 assign On_date_a= (32<=pix_x) && (pix_x<208) && (pix_y[9:5]==5'd1);
	 assign db_f_a=pix_x[3:1]; 
	 assign df_f_a=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h0: caracter_f_a = 7'h00;	//
			4'h1: caracter_f_a = 7'h00;	//
			4'h2: caracter_f_a = 7'h00;	//
			4'h3: caracter_f_a = 7'h00;	//
			4'h4: caracter_f_a = 7'h00;	//
			4'h5: caracter_f_a = 7'h46;	//F
			4'h6: caracter_f_a = 7'h65;	//e
			4'h7: caracter_f_a = 7'h63;	//c
			4'h8: caracter_f_a = 7'h68;	//h
			4'h9: caracter_f_a = 7'h61;	//a
			4'ha: caracter_f_a = 7'h00;	//
			4'hb: caracter_f_a = 7'h00;	//
			4'hc: caracter_f_a = 7'h00;	//
			4'hd: caracter_f_a = 7'h00;	//
			4'he: caracter_f_a = 7'h00;	//
			4'hf: caracter_f_a = 7'h00;	//
			default: caracter_f_a = 7'h00;	//
		endcase
	 end
	 
	 assign On_date_b= (pix_y[9:5]==5'd1) && (15<=pix_x[9:4]) && (pix_x[9:4]<26);
	 assign db_f_b=pix_x[3:1];
	 assign df_f_b=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hf: caracter_f_b={3'b011,dia[7:4]};	// decenas d�a
			4'h0: caracter_f_b={3'b011,dia[3:0]};	// unidades d�a
			4'h1: caracter_f_b=7'h2f;	// '/'
			4'h2: caracter_f_b={3'b011,mes[7:4]};	// decenas mes
			4'h3: caracter_f_b={3'b011,mes[3:0]};	// unidades mes
			4'h4: caracter_f_b=7'h2f;	// '/'
			4'h5: caracter_f_b={3'b011,year[7:4]};	//	decenas a�o
			4'h6: caracter_f_b={3'b011,year[3:0]};	//	unidades a�o
			default: caracter_f_b=7'h00;	//
		endcase
	 end
	 
	 assign On_date_c= (pix_y[9:5]==5'd1) && (28<=pix_x[9:4]) && (pix_x[9:4]<38);
	 assign db_f_c=pix_x[3:1];
	 assign df_f_c=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hd: caracter_f_c=7'h64;	//d
			4'he: caracter_f_c=7'h64;	//d
			4'hf: caracter_f_c=7'h2f;	// '/'
			4'h0: caracter_f_c=7'h6d;	//m
			4'h1: caracter_f_c=7'h6d;	//m
			4'h2: caracter_f_c=7'h2f;	// '/'
			4'h3: caracter_f_c=7'h61;	//a
			4'h4: caracter_f_c=7'h61;	//a
			default: caracter_f_c=7'h00;	//
		endcase
	 end
	 
	 assign On_hour_a= (pix_y[9:5]==3) && (6'd2<=pix_x[9:4]) && (pix_x[9:4]<6'd13);
	 assign db_h_a=pix_x[3:1];
	 assign df_h_a=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h5: caracter_h_a=7'h48;	//H
			4'h6: caracter_h_a=7'h6f;	//o
			4'h7: caracter_h_a=7'h72;	//r
			4'h8: caracter_h_a=7'h61;	//a
			default: caracter_h_a=7'h00;	//
		endcase
	 end
	 
	 assign On_hour_b= (pix_y[9:5]==5'd3) && (15<=pix_x[9:4]) && (pix_x[9:4]<26);
	 assign db_h_b=pix_x[3:1];
	 assign df_h_b=pix_y[4:1];
	 always @*
	 begin
		 case (am_pm)
			 1'h0: X_next=7'h61;		//a
			 1'h1: X_next=7'h70;				//p
			 default: X_next=7'h61;
		 endcase
		 case (formato)
			1'h0:					//formato 24h, no se escribe nada de am || pm
			begin
				m_on=7'h00;
				X_ap=7'h00;
			end
			1'h1:					//formato 12h
			begin
				m_on=7'h6d;
				X_ap=X_next;
			end
			default: 
			begin
				m_on=7'h00;
				X_ap=7'h00;
			end
		endcase
		case (pix_x[7:4])
			4'hf: caracter_h_b={3'b011,hora[7:4]};	// decenas hora
			4'h0: caracter_h_b={3'b011,hora[3:0]};	// unidades hora
			4'h1: caracter_h_b=7'h3a;					//:
			4'h2: caracter_h_b={3'b011,min[7:4]};	// decenas minuto
			4'h3: caracter_h_b={3'b011,min[3:0]};	// unidades minuto
			4'h4: caracter_h_b=7'h3a;					//:
			4'h5: caracter_h_b={3'b011,seg[7:4]};	//	decenas segundo
			4'h6: caracter_h_b={3'b011,seg[3:0]};	//	unidades segundo
			4'h7: caracter_h_b=7'h00;					//
			4'h8: caracter_h_b=X_ap;						// X (a || p)
			4'h9: caracter_h_b=m_on;						//m
			default: caracter_h_b=7'h00;				//
		endcase
	 end
	 
	 assign On_hour_c= (pix_y[9:5]==5'd3) && (29<=pix_x[9:4]) && (pix_x[9:4]<31);
	 assign db_h_c=pix_x[3:1];
	 assign df_h_c=pix_y[4:1];
	 always @*
	 begin
		case (formato)
			1'h0: veint_sign=7'h09;
			1'h1: veint_sign=7'h00;
			default: veint_sign=7'h09;
		endcase
		case (pix_x[7:4])
			4'he: caracter_h_c = veint_sign;	// �
			default: caracter_h_c =7'h00;	//
		endcase
	 end
	 
	 assign On_hour_d= (pix_y[9:5]==5'd3) && (31<=pix_x[9:4]) && (pix_x[9:4]<38);
	 assign db_h_d=pix_x[3:1];
	 assign df_h_d=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h0: caracter_h_d =7'h32;		//2
			4'h1: caracter_h_d =7'h34;		//4
			4'h2: caracter_h_d =7'h68;		//h
			default: caracter_h_d =7'h00;	//
		endcase
	 end
	 
	 assign On_hour_e= (pix_y[9:5]==5'd4) && (15<=pix_x[9:4]) && (pix_x[9:4]<26);
	 assign db_h_e=pix_x[3:1];
	 assign df_h_e=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hf: caracter_h_e=7'h68;	//h
			4'h0: caracter_h_e=7'h68;	//h
			4'h1: caracter_h_e=7'h3a;	//:
			4'h2: caracter_h_e=7'h6d;	//m
			4'h3: caracter_h_e=7'h6d;	//m
			4'h4: caracter_h_e=7'h3a;	//:
			4'h5: caracter_h_e=7'h73;	//s
			4'h6: caracter_h_e=7'h73;	//s
			default: caracter_h_e=7'h00;	//
		endcase
	 end
	 
	 assign On_hour_f= (pix_y[9:5]==5'd4) && (29<=pix_x[9:4]) && (pix_x[9:4]<31);
	 assign db_h_f=pix_x[3:1];
	 assign df_h_f=pix_y[4:1];
	 always @*
	 begin
		case (formato)
			1'h0: doce_sign=7'h00;
			1'h1: doce_sign=7'h09;
			default: doce_sign=7'h09;
		endcase
		case (pix_x[7:4])
			4'he: caracter_h_f=doce_sign;	// �
			default: caracter_h_f=7'h00;	//
		endcase
	 end
	 
	 assign On_hour_g= (pix_y[9:5]==5'd4) && (31<=pix_x[9:4]) && (pix_x[9:4]<38);
	 assign db_h_g=pix_x[3:1];
	 assign df_h_g=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h0: caracter_h_g=7'h31;	//1
			4'h1: caracter_h_g=7'h32;	//2
			4'h2: caracter_h_g=7'h68;	//h
			default: caracter_h_g=7'h00;	//
		endcase
	 end
	 
	 assign On_cron_a= (pix_y[9:5]==5'd6) && (6'd2<=pix_x[9:4]) && (pix_x[9:4]<6'd13);
	 assign db_c_a=pix_x[3:1];
	 assign df_c_a=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h3: caracter_c_a=7'h43;	//C
			4'h4: caracter_c_a=7'h72;	//r
			4'h5: caracter_c_a=7'h6f;	//o
			4'h6: caracter_c_a=7'h6e;	//n
			4'h7: caracter_c_a=7'h6f;	//o
			4'h8: caracter_c_a=7'h6d;	//m
			4'h9: caracter_c_a=7'h65;	//e
			4'ha: caracter_c_a=7'h74;	//t
			4'hb: caracter_c_a=7'h72;	//r
			4'hc: caracter_c_a=7'h6f;	//o
			default: caracter_c_a=7'h00;	//
		endcase
	 end
	 
	 assign On_cron_b= (pix_y[9:5]==5'd6) && (15<=pix_x[9:4]) && (pix_x[9:4]<26);
	 assign db_c_b=pix_x[3:1];
	 assign df_c_b=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hf: caracter_c_b={3'b011,hcrono[7:4]};	// decenas hcrono
			4'h0: caracter_c_b={3'b011,hcrono[3:0]};	// unidades hcrono
			4'h1: caracter_c_b=7'h3a;						//:
			4'h2: caracter_c_b={3'b011,mcrono[7:4]};	// decenas mcrono
			4'h3: caracter_c_b={3'b011,mcrono[3:0]};	// unidades mcrono
			4'h4: caracter_c_b=7'h3a;						//:
			4'h5: caracter_c_b={3'b011,scrono[7:4]};	//	decenas scrono
			4'h6: caracter_c_b={3'b011,scrono[3:0]};	//	unidades scrono
			default: caracter_c_b=7'h00;	//
		endcase
	 end
	 
	 assign On_cron_c= (pix_y[9:5]==5'd6) && (28<=pix_x[9:4]) && (pix_x[9:4]<38);
	 assign db_c_c=pix_x[3:1];
	 assign df_c_c=pix_y[4:1];
	 always @*
	 begin
		case (crono_end)
			1'h0: RING = 7'h00;
			1'h1: RING = 7'h01;
			default: RING = 7'h00;	
		endcase
		case (pix_x[7:4])
			4'hd: caracter_c_c=RING;	// �
			default: caracter_c_c=7'h00;	//
		endcase
	 end
	 
	 assign On_cron_d= (pix_y[9:5]==5'd7) && (15<=pix_x[9:4]) && (pix_x[9:4]<26);
	 assign db_c_d=pix_x[3:1];
	 assign df_c_d=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hf: caracter_c_d={3'b011,hcrono_run[7:4]};	// decenas hcrono_run
			4'h0: caracter_c_d={3'b011,hcrono_run[3:0]};	// unidades hcrono_run
			4'h1: caracter_c_d=7'h3a;						//:
			4'h2: caracter_c_d={3'b011,mcrono_run[7:4]};	// decenas mcrono_run
			4'h3: caracter_c_d={3'b011,mcrono_run[3:0]};	// unidades mcrono_run
			4'h4: caracter_c_d=7'h3a;						//:
			4'h5: caracter_c_d={3'b011,scrono_run[7:4]};	//	decenas scrono_run
			4'h6: caracter_c_d={3'b011,scrono_run[3:0]};	//	unidades scrono_run
			default: caracter_c_d=7'h00;	//
		endcase
	 end
	 
	 assign On_divisor_pant = (pix_y[9:5]==4'd8) && (1<=pix_x[9:4]) && (pix_x[9:4]<39);
	 assign db_d_p=pix_x[3:1];
	 assign df_d_p=pix_y[4:1];
	 always @*
	 begin
		case(pix_x[9:4])
			6'h00: caracter_d_p = 7'h00;			//
			default: caracter_d_p = 7'h16;		//?
		endcase
	 end
	 
	 assign On_prog_a= (pix_y[9:5]==5'd9) && (6'd2<=pix_x[9:4]) && (pix_x[9:4]<6'd19);
	 assign db_p_a=pix_x[3:1];
	 assign df_p_a=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h3: caracter_p_a = 7'h50;	//P
			4'h4: caracter_p_a = 7'h72;	//r
			4'h5: caracter_p_a = 7'h6f;	//o
			4'h6: caracter_p_a = 7'h67;	//g
			4'h7: caracter_p_a = 7'h2e;	//.
			4'h8: caracter_p_a = 7'h00;	//
			4'h9: caracter_p_a = 7'h66;	//f
			4'ha: caracter_p_a = 7'h65;	//e
			4'hb: caracter_p_a = 7'h63;	//c
			4'hc: caracter_p_a = 7'h68;	//h
			4'hd: caracter_p_a = 7'h61;	//a
			4'he: caracter_p_a = 7'h00;	//
			4'hf: caracter_p_a = 7'h53;	//S
			4'h0: caracter_p_a = 7'h57;	//W
			4'h1: caracter_p_a = 7'h31;	//1
			default: caracter_p_a=7'h00;	//
		endcase
	 end
	 
	 assign On_prog_b= (pix_y[9:5]==5'd11) && (2<=pix_x[9:4]) && (pix_x[9:4]<19);
	 assign db_p_b=pix_x[3:1];
	 assign df_p_b=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h3: caracter_p_b = 7'h50;	//P
			4'h4: caracter_p_b = 7'h72;	//r
			4'h5: caracter_p_b = 7'h6f;	//o
			4'h6: caracter_p_b = 7'h67;	//g
			4'h7: caracter_p_b = 7'h2e;	//.
			4'h8: caracter_p_b = 7'h00;	//
			4'h9: caracter_p_b = 7'h68;	//h
			4'ha: caracter_p_b = 7'h6f;	//o
			4'hb: caracter_p_b = 7'h72;	//r
			4'hc: caracter_p_b = 7'h61;	//a
			4'hd: caracter_p_b = 7'h00;	//
			4'he: caracter_p_b = 7'h00;	//
			4'hf: caracter_p_b = 7'h53;	//S
			4'h0: caracter_p_b = 7'h57;	//W
			4'h1: caracter_p_b = 7'h32;	//2
			default: caracter_p_b=7'h00;	//
		endcase
	 end
	 
	 assign On_prog_c= (pix_y[9:5]==5'd13) && (2<=pix_x[9:4]) && (pix_x[9:4]<19);
	 assign db_p_c=pix_x[3:1];
	 assign df_p_c=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h3: caracter_p_c = 7'h50;	//P
			4'h4: caracter_p_c = 7'h72;	//r
			4'h5: caracter_p_c = 7'h6f;	//o
			4'h6: caracter_p_c = 7'h67;	//g
			4'h7: caracter_p_c = 7'h2e;	//.
			4'h8: caracter_p_c = 7'h00;	//
			4'h9: caracter_p_c = 7'h63;	//c
			4'ha: caracter_p_c = 7'h72;	//r
			4'hb: caracter_p_c = 7'h6f;	//o
			4'hc: caracter_p_c = 7'h6e;	//n
			4'hd: caracter_p_c = 7'h6f;	//o
			4'he: caracter_p_c = 7'h00;	//
			4'hf: caracter_p_c = 7'h53;	//S
			4'h0: caracter_p_c = 7'h57;	//W
			4'h1: caracter_p_c = 7'h33;	//3
			default: caracter_p_c=7'h00;	//
		endcase
	 end
	 
	 assign On_desp= (pix_y[9:5]==5'd10) && (6'd23<=pix_x[9:4]) && (pix_x[9:4]<6'd37);
	 assign db_d=pix_x[3:1];
	 assign df_d=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'h7: caracter_d = 7'h44;	//D
			4'h8: caracter_d = 7'h65;	//e
			4'h9: caracter_d = 7'h73;	//s
			4'ha: caracter_d = 7'h70;	//p
			4'hb: caracter_d = 7'h6c;	//l
			4'hc: caracter_d = 7'h61;	//a
			4'hd: caracter_d = 7'h7a;	//z
			4'he: caracter_d = 7'h61;	//a
			4'hf: caracter_d = 7'h6d;	//m
			4'h0: caracter_d = 7'h69;	//i
			4'h1: caracter_d = 7'h65;	//e
			4'h2: caracter_d = 7'h6e;	//n
			4'h3: caracter_d = 7'h74;	//t
			4'h4: caracter_d = 7'h6f;	//o
			default: caracter_d = 7'h00;	//
		endcase
	 end

	 assign On_flec_u = (pix_y[9:5]==11) && (29<=pix_x[9:4]) && (pix_x[9:4]<30);	//Flecha hacia arriba
	 assign db_a_u=pix_x[3:1];
	 assign df_a_u=pix_y[4:1];
	 always @*
	 begin	 
		case (pix_x[7:4])
			4'hd: caracter_a_u=7'h0b;
			default: caracter_a_u=7'h00;	//
		endcase
	 end
	 
	 assign On_flec_l = (pix_y[9:5]==12) && (27<=pix_x[9:4]) && (pix_x[9:4]<28);	//Flecha hacia izquierda
	 assign db_a_l=pix_x[3:1];
	 assign df_a_l=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hb: caracter_a_l=7'h0e;
			default: caracter_a_l=7'h0a;	//
		endcase
	 end
	 
	 assign On_flec_r = (pix_y[9:5]==12) && (31<=pix_x[9:4]) && (pix_x[9:4]<32);	//Flecha hacia derecha
	 assign db_a_r=pix_x[3:1];
	 assign df_a_r=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hf: caracter_a_r=7'h0d;
			default: caracter_a_r=7'h0d;	//
		endcase
	 end
	 
	 assign On_flec_d = (pix_y[9:5]==13) && (29<=pix_x[9:4]) && (pix_x[9:4]<31);	//Flecha hacia abajo
	 assign db_a_d=pix_x[3:1];
	 assign df_a_d=pix_y[4:1];
	 always @*
	 begin
		case (pix_x[7:4])
			4'hd: caracter_a_d=7'h0c;
			default: caracter_a_d=7'h00;	//
		endcase
	 end
	 
	 always @* 
	 begin
	 color=12'hcc9;					//background			
		if (On_date_a) 
			begin CARACTER=caracter_f_a; DIR_FILA= df_f_a; DIR_BIT=db_f_a; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_date_b) 
			begin CARACTER=caracter_f_b; DIR_FILA= df_f_b; DIR_BIT=db_f_b; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_date_c)  
			begin CARACTER=caracter_f_c; DIR_FILA= df_f_c; DIR_BIT=db_f_c; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end
				
		else if (On_borde_up)
			begin CARACTER=caracter_b_u; DIR_FILA= df_b_u; DIR_BIT=db_b_u;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_borde_down)
			begin CARACTER=caracter_b_d; DIR_FILA= df_b_d; DIR_BIT=db_b_d;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_borde_left)
			begin CARACTER=caracter_b_l; DIR_FILA= df_b_l; DIR_BIT=db_b_l;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_borde_right)
			begin CARACTER=caracter_b_r; DIR_FILA= df_b_r; DIR_BIT=db_b_r;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_corner_up_left)
			begin CARACTER=caracter_c_u_l; DIR_FILA= df_c_u_l; DIR_BIT=db_c_u_l;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_corner_down_left)
			begin CARACTER=caracter_c_d_l; DIR_FILA= df_c_d_l; DIR_BIT=db_c_d_l;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_corner_up_right)
			begin CARACTER=caracter_c_u_r; DIR_FILA= df_c_u_r; DIR_BIT=db_c_u_r;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		else if (On_corner_down_right)
			begin CARACTER=caracter_c_d_r; DIR_FILA= df_c_d_r; DIR_BIT=db_c_d_r;
				if (fuente_bit) color=12'hf50;				//Letras, naranja
			end
		
		else if (On_hour_a)  
			begin CARACTER=caracter_h_a; DIR_FILA= df_h_a; DIR_BIT=db_h_a; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_hour_b)  
			begin CARACTER=caracter_h_b; DIR_FILA= df_h_b; DIR_BIT=db_h_b; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_hour_c)  
			begin CARACTER=caracter_h_c; DIR_FILA= df_h_c; DIR_BIT=db_h_c; 
				if (fuente_bit) color=12'h0a0;				//Indicador de formato, verde
			end 
		else if (On_hour_d) 
			begin CARACTER=caracter_h_d; DIR_FILA= df_h_d; DIR_BIT=db_h_d; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end
		else if (On_hour_e) 
			begin CARACTER=caracter_h_e; DIR_FILA= df_h_e; DIR_BIT=db_h_e; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end
		else if (On_hour_f) 
			begin CARACTER=caracter_h_f; DIR_FILA= df_h_f; DIR_BIT=db_h_f; 
				if (fuente_bit) color=12'h0a0;				//Indicador de formato, verde
			end
		else if (On_hour_g) 
			begin CARACTER=caracter_h_g; DIR_FILA= df_h_g; DIR_BIT=db_h_g; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end
		
		else if (On_cron_a) 
			begin CARACTER=caracter_c_a; DIR_FILA= df_c_a; DIR_BIT=db_c_a; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_cron_b) 
			begin CARACTER=caracter_c_b; DIR_FILA= df_c_b; DIR_BIT=db_c_b; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_cron_c)  
			begin CARACTER=caracter_c_c; DIR_FILA= df_c_c; DIR_BIT=db_c_c; 
				if (fuente_bit) color=12'he00;			//Bot�n de ring, rojo
			end
		else if (On_cron_d)  
			begin CARACTER=caracter_c_d; DIR_FILA= df_c_d; DIR_BIT=db_c_d; 
				if (fuente_bit) color=12'h007;			//Letras, navy
			end
		else if (On_divisor_pant)
			begin CARACTER=caracter_d_p; DIR_FILA= df_d_p; DIR_BIT=db_d_p; 
				if (fuente_bit) color=12'h007;			//Linea divisoria
			end
		else if (On_prog_a)  
			begin CARACTER=caracter_p_a; DIR_FILA= df_p_a; DIR_BIT=db_p_a; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_prog_b)  
			begin CARACTER=caracter_p_b; DIR_FILA= df_p_b; DIR_BIT=db_p_b; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_prog_c)  
			begin CARACTER=caracter_p_c; DIR_FILA= df_p_c; DIR_BIT=db_p_c; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end
			
		else if (On_desp)   
			begin CARACTER=caracter_d; DIR_FILA= df_d; DIR_BIT=db_d; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
			
		else if (On_flec_u)
			begin CARACTER=caracter_a_u; DIR_FILA= df_a_u; DIR_BIT=db_a_u; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_flec_d)  
			begin CARACTER=caracter_a_d; DIR_FILA= df_a_d; DIR_BIT=db_a_d; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_flec_r) 
			begin CARACTER=caracter_a_r; DIR_FILA= df_a_r; DIR_BIT=db_a_r; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end 
		else if (On_flec_l) 
			begin CARACTER=caracter_a_l; DIR_FILA= df_a_l; DIR_BIT=db_a_l; 
				if (fuente_bit) color=12'h007;				//Letras, navy
			end
		else begin CARACTER=7'h00; DIR_BIT=pix_x[3:1]; DIR_FILA=pix_y[4:1]; color=12'hcc9; end
	 end
	 
	 assign DIR_MEMO={CARACTER,DIR_FILA};
	 assign fuente_bit=PALABRA[~DIR_BIT];
endmodule
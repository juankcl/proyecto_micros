; Programa que genera interrupciones
LIST P = 18f45K50
#include<p18f45K50.inc> 
 
; Sección de bits de configuracion inicial
CONFIG WDTEN = OFF  ; Disables the Watchdog
CONFIG MCLRE = ON; Enables MCLEAR
CONFIG DEBUG = OFF ; Disables Debug mode
CONFIG LVP = OFF  ; Disables Low-Voltage programming
CONFIG FOSC = INTOSCIO ; Enables  the internal oscillator 
  
; Declaracion de variables en la memoria de datos
Aux1 EQU 0x00 ; Reserves register 0
Aux2 EQU 0x01  ; Reserves register 1
Base1 EQU 0x02
Segundero EQU 0x03

; Directiva que indica en que direccion de la memoria de programa se colocara la primera instruccion    
org 0
GOTO Start 


Start:
	MOVLB 0x0F 
	CLRF ANSELD,1
	CLRF ANSELC,1
	CLRF PORTC ; Cleans PORT D
	CLRF TRISC
	CLRF PORTD
	CLRF TRISD
	CLRF Aux1
	CLRF Aux2

	CLRF PORTA

	MOVLW b'1000100'
	MOVWF T0CON
	
	MOVLW b'11100000'
	MOVWF INTCON
	
	BSF RCON,7
	
	MOVLW b'00000001'
	MOVWF PORTD
	
	MOVLW b'01010000'
	MOVWF OSCCON

;Ciclo principal
MainLoop:
	RRNCF PORTD,f
	CALL Retardo
	GOTO MainLoop

Retardo:
	DECFSZ Aux1,1
		GOTO Retardo
	DECFSZ Aux2,1
		GOTO Retardo
	RETURN

end
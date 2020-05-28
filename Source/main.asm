; Programa que genera interrupciones
LIST P = 18f45K50
#include<p18f45K50.inc> 
#include<common.inc>
		
; Funciones externas
; LCD
EXTERN LCDInit, LCD_Comm, LCD_Char, LCDDia
	
; Seccion de bits de configuracion inicial
CONFIG WDTEN = OFF  ; Disables the Watchdog
CONFIG MCLRE = ON; Enables MCLEAR
CONFIG DEBUG = OFF ; Disables Debug mode
CONFIG LVP = OFF  ; Disables Low-Voltage programming
CONFIG FOSC = INTOSCIO ; Enables  the internal oscillator 
  
; Declaracion de variables en la memoria de datos
Aux1 EQU 0x00 ; Reserves register 0

; Directiva que indica en que direccion de la memoria de programa se colocara la primera instruccion    
org 0
GOTO Start 

Start:
	MOVLB 0x0F
	
	CLRF ANSELD,1 ; Dejar todos los canales en digitales
	CLRF PORTD ; Cleans PORT D
	CLRF TRISD ; Sets PORT D pins as outputs
	
	CLRF ANSELB,1 ; Dejar todos los canales en digitales
	CLRF PORTB ; Cleans PORT D
	CLRF TRISB ; Sets PORT D pins as outputs

	MOVLW b'01010011' ; Configures OSCCON register
	MOVWF OSCCON

	; Inicializar la pantalla LCD
	CALL Retardo
	CALL LCDInit

	; Mandar un numero del 0 al 6, 0 siendo lunes y 6 siendo domingo
	
	MOVLW 3
	CALL LCDDia
	
;Ciclo principal
MainLoop:
	GOTO MainLoop

Retardo:
	DECFSZ Aux1,1
		GOTO Retardo
	RETURN
	GLOBAL Retardo

end
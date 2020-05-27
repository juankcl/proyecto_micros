; Pantalla LCD PIC
LIST P = 18f45K50
#include<p18f45K50.inc>

; Funciones externas
EXTERN Retardo

CODE

; Inicializar la pantalla lcd
LCDInit:
	Call Retardo
	MOVLW h'0F' ; Comando para prender la pantalla con cursor
	CALL LCD_Comm

	MOVLW h'38' ; Comando para configurar la pantalla en modo 8 bits
	CALL LCD_Comm
	RETURN
	GLOBAL LCDInit

; Poner en el registro W el commando a ejecutar antes de llamar a esta funci�n
LCD_Comm:
	MOVWF PORTB
	BCF PORTD, 0 ; Registro de commandos
	BSF PORTD, 1 ; Mandar un pulso en alto al pin de Enable
	NOP
	BCF PORTD, 1
	Call Retardo
	RETURN
	GLOBAL LCD_Comm

; Poner en el registro W el caracter a mostrar antes de llamar a esta funci�n
LCD_Char:
	MOVWF PORTB
	BSF PORTD, 0 ; Mandar datos
	BSF PORTD, 1 ; Mandar un pulso en alto al pin de Enable
	NOP
	BCF PORTD, 1 ; Desactivar el pin Enable
	Call Retardo
	RETURN
	GLOBAL LCD_Char
end
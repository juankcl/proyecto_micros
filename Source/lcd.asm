; Pantalla LCD PIC
LIST P = 18f45K50
#include<p18f45K50.inc>
#include<common.inc>
	
; Funciones externas
EXTERN Retardo
AuxLcd EQU 0X02
	
CODE

LCDInit:
	Call Retardo
	MOVLW h'0C' ; Comando para prender la pantalla
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

; Mostrar dias de la semana
SABADO:
    MOVLW 'S'
	CALL LCD_Char
	MOVLW 'a'
	CALL LCD_Char
	MOVLW 'b'
	CALL LCD_Char
	MOVLW 'a'
	CALL LCD_Char
	MOVLW 'd'
	CALL LCD_Char
	MOVLW 'o'
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
    RETURN
DOMINGO:
    MOVLW 'D'
	CALL LCD_Char
	MOVLW 'o'
	CALL LCD_Char
	MOVLW 'm'
	CALL LCD_Char
	MOVLW 'i'
	CALL LCD_Char
	MOVLW 'n'
	CALL LCD_Char
	MOVLW 'g'
	CALL LCD_Char
	MOVLW 'o'
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
    RETURN

; Mostrar el dia de la semana en la pantalla
LCDDia:
	
	MOVWF AuxLcd
	MOVLW h'80'
	CALL LCD_Comm
	
	MOVF AuxLcd, w
	
	XORLW 0
	BZ LUNES
		
	XORLW 1^0
	BZ MARTES
		
	XORLW 2^1
	BZ MIERCOLES
	
	XORLW 3^2
	BZ JUEVES
	
	XORLW 4^3
	BZ VIERNES
	
	XORLW 5^4
	BZ SABADO
	
	XORLW 6^5
	BZ DOMINGO
	
	RETURN
	GLOBAL LCDDia

LUNES:
    MOVLW 'L'
	CALL LCD_Char
	MOVLW 'u'
	CALL LCD_Char
	MOVLW 'n'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 's'
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
    RETURN
MARTES:
    MOVLW 'M'
	CALL LCD_Char
	MOVLW 'a'
	CALL LCD_Char
	MOVLW 'r'
	CALL LCD_Char
	MOVLW 't'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 's'
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
    RETURN
MIERCOLES:
    MOVLW 'M'
	CALL LCD_Char
	MOVLW 'i'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 'r'
	CALL LCD_Char
	MOVLW 'c'
	CALL LCD_Char
	MOVLW 'o'
	CALL LCD_Char
	MOVLW 'l'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 's'
	CALL LCD_Char
    RETURN
JUEVES:
    MOVLW 'J'
	CALL LCD_Char
	MOVLW 'u'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 'v'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 's'
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
    RETURN
VIERNES:
    MOVLW 'V'
	CALL LCD_Char
	MOVLW 'i'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 'r'
	CALL LCD_Char
	MOVLW 'n'
	CALL LCD_Char
	MOVLW 'e'
	CALL LCD_Char
	MOVLW 's'
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
	MOVLW ' '
	CALL LCD_Char
    RETURN
end
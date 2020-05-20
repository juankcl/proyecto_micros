; Programa que genera interrupciones
LIST P = 18f45K50
#include<p18f45K50.inc> 
 
; Sección de bits de configuración inicial
CONFIG WDTEN = OFF  ; Disables the Watchdog
CONFIG MCLRE = ON; Enables MCLEAR
CONFIG DEBUG = OFF ; Disables Debug mode
CONFIG LVP = OFF  ; Disables Low-Voltage programming
CONFIG FOSC = INTOSCIO ; Enables  the internal oscillator 
  
; Declaración de variables en la memoria de datos
Aux1 EQU 0x00 ; Reserves register 0
Aux2 EQU 0x01  ; Reserves register 1
Base1 EQU 0x02
Segundero EQU 0x03
org 0
GOTO Start
 ; Directiva que indica en que dirección de la memoria de programa se colocará la primera instrucción    
org 0X08    ; Sets first instruction in address 00 
GOTO INTHP
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
INTHP:
    MOVLW b'10110110'
    MOVWF TMR0L
    MOVLW b'00111100'
    INCF Base1,F
    MOVLW d'19'
    CPFSLT Base1
    GOTO Final
    BCF INTCON,2
    RETFIE
    
Final:
    CLRF Base1
    INCF Segundero
    BCF INTCON,2
    RETFIE 
Retardo:
    DECFSZ Aux1,1
    GOTO Retardo
    DECFSZ Aux2,1
    GOTO Retardo
    RETURN
    end
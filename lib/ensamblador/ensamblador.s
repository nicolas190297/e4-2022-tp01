/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified //es la misma instrucciones en otros lenguajes
.cpu cortex-m3 //
.fpu softvfp
.thumb //instrucciones fun

.macro defun nombre //macro del emsamblador
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    cbz R2,0f
    movs R12,#0
1:
    ldrb R3,[R0],#1 //carga en R3 R0 e incrementa en 1 la posicion de R0
    strb R3,[R1],#1
    adds R12,#1
    cmp R12,R2
    bne 1b
0:
    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
     cbz R2,0f
    movs R12,#0
1:
    ldrb R3,[R0],#1 //carga en R3 R0 e incrementa en 1 la posicion de R0
    strb R3,[R1],#1
    cmp R3,#0
    beq 0f
    adds R12,#1
    cmp R12,R2
    bne 1b
    movs R3,#0 //para poner en 0 R3
    strb R3[R1,#(-1)]
0:
    bx lr

endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    //uso entre 97 y 122 porque entre esos valores estan comprendidas las minusculas

    cbz R1,0f //cadena nula
1:              //si no se termina la cadena vuelvo a hacer lo mismo
    ldrb R3,[R0],#1
    cmp R3,#97 
    bmi 2f
    cmp R3,#122
    bpl 2f
    subs R3,#32 //le sumo 32
    strb R3,[R0,#(-1)]
2:          //si no es una letra analizo el siguiente termino
    subs R1,#1
    bne 1b

0:  

    bx lr

    

endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima

    //uso entre 65 y 90 porque entre esos valores estan comprendidas las mayusculas

    cbz R1,0f //cadena nula
1:              //si no se termina la cadena vuelvo a hacer lo mismo
    ldrb R3,[R0],#1
    cmp R3,#65 
    bmi 2f
    cmp R3,#90
    bpl 2f
    add R3,#32 //le sumo 32
    strb R3,[R0,#(-1)]
2:          //si no es una letra analizo el siguiente termino
    subs R1,#1
    bne 1b

0:  

    bx lr
endfun minusculaEnLugar

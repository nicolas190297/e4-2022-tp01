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
    ldrb R3[R0],#1 //carga en R3 R0 e incrementa en 1 la posicion de R0
    strb R3[R1],#1
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
    ldrb R3[R0],#1 //carga en R3 R0 e incrementa en 1 la posicion de R0
    strb R3[R1],#1
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
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun minusculaEnLugar

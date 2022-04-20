/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
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
    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    bx lr
endfun minusculaEnLugar
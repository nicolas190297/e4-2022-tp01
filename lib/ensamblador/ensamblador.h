#ifndef ENSAMBLADOR_H
#define ENSAMBLADOR_H
#include <stddef.h>
void copiaMemoria(const void *origen,void *destino,size_t longitud);
void copiaCadena(const char *origen,char *destino,size_t longitudMaxima);
void mayusculaEnLugar(char *cadena,size_t longitudMaxima);
void minusculaEnLugar(char *cadena,size_t longitudMaxima);

#endif

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../.gen/parser.h"


#define BYTES_RENGLON          bytes += strlen(yytext);
#define COLUMNAS_SUMA  BYTES_RENGLON columnas += strlen(yytext);
#define COLUMNAS_RESET columnas = 1;
#define LINEA_BYTES linea_en_bytes += bytes; bytes = 0;

void error_identificadores();
int columnas = 0;
int bytes = 0;
int linea_en_bytes = 0;


%}


/*SECCION DE OPCIONES*/
/* Esto indica a Flex que lea solo un fichero de entrada */
%option noyywrap
/* Nos permite obtener el numero de linea */
%option yylineno

/* Seccion Tokens */
NUM		       [0-9]+
Mayuscula	       [A-Z]+
Minuscula	       [a-z]+
palabra		       ({Minuscula}|{Mayuscula})+

COND    (==|<|>|=<|>=)

Identificador       [A-Z][A-Za-z0-9]*

FinDeSentencia 	    ["."]

entero    "entero"
cadena    "cadena"
si        "si"
mientras  "mientras"


%%

{Identificador}			  { if(strlen(yytext)<17) { COLUMNAS_SUMA; return IDENTIFICADOR; } \
						    else { error_identificadores();} ;} 

{entero}		          { COLUMNAS_SUMA; return ENTERO; }
{cadena}		          { COLUMNAS_SUMA; return CADENA; }
{mientras}                { COLUMNAS_SUMA; return MIENTRAS; }
{si}			          { COLUMNAS_SUMA; return SI; } 

{palabra}				  { COLUMNAS_SUMA; return PALABRA; }

{NUM}					  { COLUMNAS_SUMA; return NUM; }

{COND}					  { COLUMNAS_SUMA; return COND; }

{FinDeSentencia}          { COLUMNAS_SUMA; return FINSENTENCIA; }

"="						  { COLUMNAS_SUMA; return ASIGNACION; }
"+"						  { COLUMNAS_SUMA; return SUMA; }
"-"						  { COLUMNAS_SUMA; return RESTA; }

"\n"					  { COLUMNAS_SUMA; COLUMNAS_RESET; LINEA_BYTES; }

[ \t]				      { COLUMNAS_SUMA; }

"["		   		          { COLUMNAS_SUMA; return CORCHIZQ; }
"]"						  { COLUMNAS_SUMA; return CORCHDER; }

.						  { COLUMNAS_SUMA; return ERROR; }

%%


void error_identificadores(){	
	printf("\"%s\" no puede ser usado como identificador \n", yytext); 
	printf("Recordar que los identificadores deben tener como maximo 16 caracteres y deben empezar con Mayuscula\n");
	printf("\n");
 }

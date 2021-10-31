%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

void error_identificadores();

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

{Identificador}			  { if(strlen(yytext)<17) { return IDENTIFICADOR; } \
						    else { error_identificadores();} ;} 

{entero}		          { return ENTERO; }
{cadena}		          { return CADENA; }
{mientras}                { return MIENTRAS; }
{si}			          { return SI; } 

{palabra}				  { return PALABRA; }

{NUM}					  { return NUM; }

{COND}					  { return COND; }

{FinDeSentencia}          { return FINSENTENCIA; }

"="						  { return ASIGNACION; }
"+"						  { return SUMA; }
"-"						  { return RESTA; }

[ \t\n]				      {}

"["		   		          { return CORCHIZQ; }
"]"						  { return CORCHDER; }

.						  { return ERROR; }

%%


void error_identificadores(){	
	printf("\"%s\" no puede ser usado como identificador \n", yytext); 
	printf("Recordar que los identificadores deben tener como maximo 16 caracteres \n");
	printf("\n");
 }


%{

#include <stdio.h>

extern FILE * yyin;
extern int yylineno;
extern int yylex();

int yyerror(char *s);

%}

/* declare tokens */

%token CADENA ENTERO MIENTRAS SI
%token IDENTIFICADOR
%token FINSENTENCIA
%token SENTENCIA
%token COND ASIGNACION
%token RESTA SUMA 
%token PALABRA NUM
%token ERROR
%token CORCHIZQ CORCHDER

%%

sentencias: sentencia
		  | sentencia sentencias;

sentencia: sentencia_inicio FINSENTENCIA;

sentencia_inicio: iterador
				| condicional
				| asignacion	
				| crear_variable;

condicional: SI condicion CORCHIZQ sentencias CORCHDER;

iterador: MIENTRAS condicion CORCHIZQ sentencias CORCHDER;

asignacion: IDENTIFICADOR ASIGNACION operacion;

crear_variable: tipo IDENTIFICADOR
		      | tipo asignacion; 
			  

operacion: operador 
		 | operador operadores operador;

operadores: SUMA
		  | RESTA;

condicion: operador COND operador;

operador: IDENTIFICADOR
	    | PALABRA 
		| NUM;

tipo: CADENA
	| ENTERO;

%%


int main(int argc, char **argv)

{
	yyin = fopen(argv[1], "r");
	printf("\n");
	yylex();
	yyparse();
}

int yyerror(char *s)
{
	  fprintf(stderr, "error: %s \n", s);
	  printf("Error in line: %d \n", yylineno);
	 
}

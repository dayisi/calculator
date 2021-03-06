%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "calculator.h"

/* prototype */
nodeType *opr(int oper, int nops, ...);
nodeType *id( int i);
nodeType *con(int value);
void freeNode(nodeType *p);
int ex(nodeType *p);
int yylex(void);

void yyerror(char *s);
int sym[26];					/* symbol table of variable name*/
%}

%union{
	int iValue;					/* integer value */
	char sIndex;				/* symbol table index */
	nodeType *nPtr;				/* node pointer */
};

%token <iValue> INTEGER;
%token <sIndex> VARIABLE;
%token WHILE IF PRINT
%token MAX MIN
%nonassoc IFX
%nonassoc ELSE

%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '/' '*'
%right '^'
%nonassoc UMINUS

%type <nPtr> stmt expr stmt_list max_list min_list

%%

program:
	function			{ exit(0); }
	;

function:
	function stmt		{ ex($2); freeNode($2);}
	|	/* NULL */
	;

stmt:
		';'					{ $$ = opr(';',2,NULL, NULL);}
	| expr ';'				{ $$ = $1; }
	| PRINT expr ';'		{ $$ = opr (PRINT, 1, $2);}
	| VARIABLE '=' expr ';'		{ $$ = opr ('=', 2, id($1), $3);}
	| WHILE '(' expr ')' stmt	{$$ = opr(WHILE, 2, $3, $5);}
	| IF '(' expr ')' stmt %prec IFX {$$ = opr (IF, 2, $3, $5);}
	| IF '(' expr ')' stmt ELSE stmt	{ $$ = opr(IF, 3, $3, $5, $7);}
	| '{' stmt_list '}' 		{$$ = $2;}
	;

stmt_list:
	stmt				{$$ = $1; }
	|stmt_list stmt 	{$$ = opr(';', 2, $1, $2);}
	;

expr:
	INTEGER				{$$ = con($1);}
| VARIABLE				{$$ = id($1);}
| '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
| expr '+' expr			{ $$ = opr('+', 2, $1, $3); }
| expr '-' expr			{ $$ = opr('-', 2, $1, $3); }
| expr '*' expr			{ $$ = opr('*', 2, $1, $3); }
| expr '/' expr			{ $$ = opr('/', 2, $1, $3); }
| expr '^' expr 		{ $$ = opr('^', 2, $1, $3); }
| expr '<' expr			{ $$ = opr('<', 2, $1, $3); }
| expr '>' expr			{ $$ = opr('>', 2, $1, $3); }
| expr GE expr			{ $$ = opr(GE, 2, $1, $3); }
| expr LE expr 			{ $$ = opr(LE, 2, $1, $3); }
| expr NE expr 			{ $$ = opr(NE, 2, $1, $3); }
| expr EQ expr			{ $$ = opr(EQ, 2, $1, $3); }
| MAX '(' max_list ')' 	{ $$ = opr(MAX, 1, $3);}
| MIN '(' min_list ')'	{ $$ = opr(MIN, 1, $3);}
| '(' expr ')'			{ $$ = $2;}
;

max_list:
	expr				{ $$ = $1;}
| max_list ',' expr		{ $$ = opr(MAX, 2, $1, $3);}
;

min_list:
	expr				{ $$ = $1;}
| min_list ',' expr		{ $$ = opr(MIN, 2, $1, $3);}
;

%%

#define SIZEOF_NODETYPE ((char *)&p->con - (char *)p)

nodeType *con(int value){
	nodeType *p;
		
	/* allocate node */
	if((p = malloc(sizeof(nodeType)))==NULL){
		yyerror("out of memory");
	}
	
	/* copy data */
	p->type = typeCon;
	p->con.value = value;

	return p;

}

nodeType *id(int i){
	nodeType *p;
	
	/* allocate node */
	if((p=malloc(sizeof(nodeType)))==NULL){
		yyerror("out of memory");
	}	
	
	/* copy data */
	p->type = typeId;
	p->id.i = i;

	return p;
}

nodeType *opr(int oper, int nops, ...){
	va_list ap;			/* va: variable-argument, ap is a pointer pointing to the variable parameter */
	nodeType *p;
	int i;

	/* allocate node, extending op array */
	if((p=malloc(sizeof(nodeType)+(nops-1)* sizeof(nodeType *))) == NULL){
		yyerror("out of memory");
	}

	/* copy information */
	p->type = typeOpr;
	p->opr.oper=oper;
	p->opr.nops=nops;
	va_start(ap,nops);					/* after nops, parameters are variables */
	for( i =0; i<nops;i++){
		p->opr.op[i]=va_arg(ap, nodeType*); /* return the data pointed by ap, which is a type of nodeType */
		/* Question: why the parameter of i can increase? The declaration indicates that i can only be 0 */
	}
	va_end(ap);
	return p;
}

void freeNode(nodeType *p){
	int i;
	
	if(!p) return;
	if(p->type == typeOpr){
		for(i=0; i<p->opr.nops;i++){
			freeNode(p->opr.op[i]);		
		}
	}	
	free(p);
}

void yyerror(char *s){
	fprintf(stdout,"%s\n", s);
}

int main(void){
	yyparse();
	return 0;	
}

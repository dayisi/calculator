%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
//extern int yylval;
%}

%%
[0-9]+ {
		yylval = atoi(yytext);
		return INTEGER;
	   }
[-+*/()\n] return *yytext;

[ \t]  ; /*skip whitespace */
.      yyerror("invalid character");
%%

int yywrap(void){
	return 1;
}

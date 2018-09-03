%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
//extern int yylval;
%}

%%
	/* variable name is stored as referenced position to charactor 'a', an integer
		e.g. sym[0] represents value of variable a, sym[1] represents value of variable b*/
[a-z] {
					yylval = *yytext - 'a';
					return VARIABLE;
				 }
[0-9]+ {
		yylval = atoi(yytext);
		return INTEGER;
	   }

	/* attention that "=" is required here */
[-+*/()=\n] {
				return *yytext;
			}

[ \t]  ; /*skip whitespace */
.      yyerror("invalid character");
%%

int yywrap(void){
	return 1;
}

#include <stdio.h>
#include <math.h>
#include "calculator.h"
#include "y.tab.h"

int ex(nodeType *p){
	if(!p) return 0;
	int max =0;
	int min = 0;
	switch(p->type){
		case typeCon:			return p->con.value;
		case typeId:			return sym[p->id.i];
		case typeOpr:
			switch(p->opr.oper){
				case WHILE:		while(ex(p->opr.op[0]))
									ex(p->opr.op[1]);
								return 0;
				case IF:		if(ex(p->opr.op[0]))
									ex(p->opr.op[1]);
								else if(p->opr.nops > 2)
									ex(p->opr.op[2]);
								return 0;
				case PRINT:		printf("%d\n", ex(p->opr.op[0]));
								return 0;
				case ';':		ex(p->opr.op[0]); return ex(p->opr.op[1]);
				case '=':		return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);
				case UMINUS: 	return -ex(p->opr.op[0]);
				case '+':		return ex(p->opr.op[0]) + ex(p->opr.op[1]);
				case '-':		return ex(p->opr.op[0]) - ex(p->opr.op[1]);
				case '*':		return ex(p->opr.op[0]) * ex(p->opr.op[1]);
				case '/':		return ex(p->opr.op[0]) / ex(p->opr.op[1]);
				case '^': 		return (int)pow(ex(p->opr.op[0]), ex(p->opr.op[1])); 
				case '<':		return ex(p->opr.op[0]) < ex(p->opr.op[1]);
				case '>':		return ex(p->opr.op[0]) > ex(p->opr.op[1]);
				case GE:		return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
				case LE:		return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
				case NE:		return ex(p->opr.op[0]) != ex(p->opr.op[1]);
				case EQ:		return ex(p->opr.op[0]) == ex(p->opr.op[1]);
				case MAX:		max = ex(p->opr.op[0]);
								for( int i = 0; i < p->opr.nops;i++)
										max = (max > ex(p->opr.op[i]) ? max : ex(p->opr.op[i]));
								return max;
				case MIN:		min = ex(p->opr.op[0]);
								for( int i = 0; i < p->opr.nops;i++)
										min = (min < ex(p->opr.op[i]) ? min : ex(p->opr.op[i]));
								return min;


			}
	
	}
	return 0;
}

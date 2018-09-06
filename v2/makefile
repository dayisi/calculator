CCC = gcc
YACC = yacc
LEX = lex

lex.yy.c: calculator.l
	$(LEX) calculator.l
y.tab.c: calculator.y
	$(YACC) -y -d calculator.y
y.tab.h: calculator.y
	$(YACC) -y -d calculator.y
lex.yy.o: lex.yy.c y.tab.h calculator.h
	$(CCC) -c lex.yy.c

y.tab.o: y.tab.c y.tab.h calculator.h
	$(CCC) -c y.tab.c

calculator: lex.yy.o y.tab.o interpreter.c
	$(CCC) lex.yy.o y.tab.o interpreter.c -o calculator

execute: calculator
clean:
		/bin/rm -rf lex.yy.c y.tab.h y.tab.c
		/bin/rm -rf *.o
		/bin/rm -rf calculator

.DEFAULT_GOAL := calculator

CCC = gcc
YACC = yacc
LEX = lex


lex.yy.c: calculator.l
	$(LEX) calculator.l
y.tab.c: calculator.y
	$(YACC) -d calculator.y
y.tab.h: calculator.y
	$(YACC) -d calculator.y
lex.yy.o: lex.yy.c y.tab.h
	$(CCC) -c lex.yy.c

y.tab.o: y.tab.c y.tab.h
	$(CCC) -c y.tab.c

calculator.exe: lex.yy.o y.tab.o
	$(CCC) lex.yy.o y.tab.o -o calculator.exe

execute: calculator.exe
clean:
		/bin/rm -rf lex.yy.c y.tab.h y.tab.c
		/bin/rm -rf *.o
		/bin/rm -rf calculator.exe

all: calculator.exe

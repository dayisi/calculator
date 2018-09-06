# calculator

This is a practice to learn Lex and YACC. The reference is the manual book by Tom Niemann from epaperpress.com.

Link: https://epaperpress.com/lexandyacc/download/LexAndYaccTutorial.pdf
##################################################################################################

V0 is a sinlge calculator which can make simple calculationdd using lex and yacc.
	* The source code is referenced from Practice, Part I.
	* My work is trying to add multiplication and division functions.
	* Only integer calculation for addition, subtraction, mulplication and division with round brackets.
	* In the calculator/v0 directory, these are commands:
		make all
		./calculator
		make clean

##################################################################################################

V1 is a more complex calculator containing variables.
	* The source code is referenced from Practice, Part II.
	* Only integer calculation for addition, subtraction, mulplication and division with round brackets.
	* Variables introduced, whose name limitted in lower-case letter from a to z.
	* Default value of variables are 0.
	* Expressions must be on the right hand.
	* In the calculator/v1 directory, these are commands:
		make
		./calculator
		make clean

##################################################################################################

V2 is a more complex calculator using lex and yacc based on v1.
	* The source code is referenced from Calculator, the version of interpretor.
	* WHILE loop and IF ELSE condition statement are added.
	* You need print expression to see values.
	* >,<,==,!=,>=,<= are added.
	* Every expression must end with ";".
	* "{" and "}" are used for scope or statement list.
	* In the calculator/v1 directory, these are commands:
		make
		./calculator
		make clean

##################################################################################################

V3 adds exponential operator "^" and MAX(parameter1,parameter2,...), MIN(parameter1, parameter2,...) in the calculator of v2.


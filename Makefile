bfinterpreter: y.tab.c lex.yy.c
	gcc -o bfinterpreter y.tab.c
y.tab.c: bfinterpreter.y lex.yy.c
	yacc bfinterpreter.y
lex.yy.c: bfelexer.l
	flex bfelexer.l
clean:
	rm -f lex.yy.c y.tab.c bfinterpreter

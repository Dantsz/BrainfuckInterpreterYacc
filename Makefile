all : bfinterpreter BFToJSF
bfinterpreter: bfinterpreter.yy.c lex.yy.c
	gcc -o bfinterpreter bfinterpreter.yy.c
BFToJSF: BFToJSF.yy.c lex.yy.c
	gcc -o BFToJSF BFToJSF.yy.c 
bfinterpreter.yy.c: bfinterpreter.y lex.yy.c
	yacc bfinterpreter.y -o bfinterpreter.yy.c
BFToJSF.yy.c : BFToJSF.y lex.yy.c
	yacc BFToJSF.y -o BFToJSF.yy.c 
lex.yy.c: bfelexer.l
	flex bfelexer.l
clean:
	rm -f lex.yy.c BFToJSF.yy.c bfinterpreter.yy.c bfinterpreter BFToJSF

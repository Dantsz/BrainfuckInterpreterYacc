/* printint.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char* concatenate_strings(char* str1, char op ,char* str2) {
    size_t len1 = strlen(str1);
    size_t len2 = strlen(str2);
    char* result = malloc(len1 + len2 + 3);
    result[0] = '(';
    if (result) {
        memcpy(result + 1, str1, len1);
        result[len1 + 1] = op;
        memcpy(result + len1 + 2, str2, len2 + 1);
    }
    result[len1 + len2 + 2] = ')';
    return result;
}
%}

%union {char* termen; char operator;}
%start S
%token<termen> NUMBER
%token<operator> OPERATOR
%type<termen> EXP
%%
EXP : EXP EXP OPERATOR
    {
        $$ = concatenate_strings($1,$3,$2);
        free($1);
        free($2);
    }
    | NUMBER
    ;
S : EXP {printf("%s" , $1);};
%%#include <stdio.h>
#include "lex.yy.c"
main() {
	return yyparse();
}
int yyerror( char *s ) { fprintf( stderr, "%s\n", s); }
/* printint.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DATA_SIZE 30000
unsigned char data[DATA_SIZE];
size_t data_pointer;

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

%union {char* termen; char operator; int offset;}
%start S
//%token<termen> NUMBER
//%token<operator> OPERATOR
%type<termen> EXP
%token PINCREMENT 
%token PDECREMENT 
%token DINCREMENT 
%token DDECREMENT 
%token WRITE 
%token READ
%token<offset> LOOPBEGIN
%token LOOPEND
%%

program: EXP
       | program EXP
       ;

EXP : PINCREMENT {if(data_pointer > DATA_SIZE ) {data_pointer ++;}};
    | PDECREMENT {if(data_pointer > 0 ){data_pointer--;} }
    | DINCREMENT {data[data_pointer]++;}
    | DDECREMENT {data[data_pointer]--;}
    | WRITE {printf("%d", (int)data[data_pointer]);}
    | while_statement
    ;
while_statement: LOOPBEGIN program LOOPEND ;

S : program;
%%#include <stdio.h>
#include "lex.yy.c"
main() {
    data_pointer = 0;
    memset(data,0,DATA_SIZE);
	return yyparse();
}
int yyerror( char *s ) { fprintf( stderr, "%s\n", s); }
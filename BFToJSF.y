/* printint.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
extern int offset;

#define DATA_SIZE 30000
unsigned char data[DATA_SIZE];
int stack[DATA_SIZE];
size_t stack_pointer;

size_t data_pointer;

const char * DDP_str;
const char * DTP_str;
const char * IDP_str;
const char * ITP_str;
const char * LOOP_BEGIN_str;
const char * LOOP_END_str;
const char * READ_str;
const char * WRITE_str;

%}

%union {char* termen; int offset;}
%start S
%type<termen> EXP
%type <offset> loop_begin
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

EXP : PINCREMENT {printf("data_pointer++;");}
    | PDECREMENT {printf("data_pointer--;");}
    | DINCREMENT {printf("data[data_pointer]++;");}
    | DDECREMENT {printf("data[data_pointer]--;");}
    | WRITE {printf("console.log(String.fromCharCode(data[data_pointer]));");}
    | LOOPBEGIN {printf("while(data[data_pointer]){");}
    | LOOPEND {printf("}");}
    ;
prelude : {printf("var data = new Array(30000).fill(0);var data_pointer = 0;");};
S : prelude program;
%%#include <stdio.h>
#include "lex.yy.c"
main() {
    data_pointer = 0;
    memset(data,0,DATA_SIZE);
	return yyparse();
}

int yyerror( char *s ) { fprintf( stderr, "%s\n", s); }
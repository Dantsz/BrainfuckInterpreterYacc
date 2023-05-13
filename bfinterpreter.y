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

EXP : PINCREMENT {if(data_pointer < DATA_SIZE ) {data_pointer ++;}};
    | PDECREMENT {if(data_pointer > 0 ){data_pointer--;} }
    | DINCREMENT {data[data_pointer]++;}
    | DDECREMENT {data[data_pointer]--;}
    | WRITE {printf("%c",data[data_pointer]);}
    | while_statement
    ;
loop_begin: LOOPBEGIN { /*printf("LOOP BEGIN AT %d\n",$1);*/ $$ = $1; stack_pointer++; stack[stack_pointer] = $$;}; 
loop_end : LOOPEND {
    if(data[data_pointer])
    {
        fseek(yyin,stack[stack_pointer] - 1,SEEK_SET);
        offset = stack[stack_pointer] - 1;
        yyrestart(yyin);
    }
    else
    {
       stack_pointer--;
    }
  
};  
while_statement: loop_begin program loop_end ;

S : program;
%%#include <stdio.h>
#include "lex.yy.c"
main() {
    data_pointer = 0;
    memset(data,0,DATA_SIZE);
	return yyparse();
}

int yyerror( char *s ) { fprintf( stderr, "%s\n", s); }
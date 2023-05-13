%{
    int offset = 0;
    #define YY_USER_ACTION offset += yyleng; 
%}
%%
\> {return PINCREMENT;}
\< {return PDECREMENT;}
\+ {return DINCREMENT;}
\- {return DDECREMENT;}
\. {return WRITE;} 
\, {return READ;}
\[ { yylval.offset = offset; return LOOPBEGIN;} 
\] {return LOOPEND;}
. ;
%%
int yywrap() { return 1; }



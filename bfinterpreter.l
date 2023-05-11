%%
[0-9]+ { yylval.termen = strdup(yytext); return NUMBER; }
[+-\/\*] { yylval.operator = yytext[0]; return OPERATOR;}
\< {return PINCREMENT;}
\> {return PDECREMENT;}
\+ {return DINCREMENT;}
\- {return DDECREMENT;}
\. {return WRITE;} 
\, {return READ;}
\[ {return LOOPBEGIN;} 
\] {return LOOPEND;}

. ;
%%

int yywrap() { return 1; }

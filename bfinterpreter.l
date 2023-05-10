%%
[0-9]+ { yylval.termen = strdup(yytext); return NUMBER; }
[+-\/\*] { yylval.operator = yytext[0]; return OPERATOR;}
. ;
%%

int yywrap() { return 1; }

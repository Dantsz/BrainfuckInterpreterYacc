%%
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

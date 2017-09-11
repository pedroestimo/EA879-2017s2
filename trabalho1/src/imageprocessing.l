
%{
#include <stdlib.h>
#include <string.h>
void yyerror(char *);

#include "y.tab.h"
%}



%%
[*]  { return MULT; }

[/]  { return DIV; }

\[  { return ACOL; }

\]  { return FCOL; }

\"  { return ASPA; }

[=]  { return IGUAL; }

\n  { return EOL; }

[ \t]+ ;

[a-z]  {
       yylval.ival = yytext[0] - 'a';
       return VAR;
       }

[0-9]*\.?[0-9]+  {
       for (int i = 0; i<yyleng; i++){
         yyval.fval = atof (yytext);
         }
       return FLOAT;   
       }

[a-zA-Z0-9\.]+  {
        for (int i = 0; i < yyleng; i++ )
          yylval.strval[i] = yytext[i];

        yylval.strval[yyleng] = '\0';
        printf ("Achei nome: %s\n", yylval.strval);
        return STRING;
       }

.  {printf("**%s**\n", yytext);
yyerror("Token nao reconhecido!\n");}

%%

int  yywrap() {
  return 1;
}

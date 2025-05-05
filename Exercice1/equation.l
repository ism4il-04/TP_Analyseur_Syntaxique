%option noyywrap
%{
#include "equation.tab.h"
%}

%%
[0-9]+             { yylval.nb = atoi(yytext); return NB; }
"X"                { return X; }
"*"                { return MULT; }
"^2"               { return PUIS; }
"+"                { return PLUS; }
[ \t\n]+           
.                  { printf("caractere non reconnu : %s\n", yytext); }
%%
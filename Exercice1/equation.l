%{
#include "equation.tab.h" // Fichier généré par Bison
%}

%%
[0-9]+             { yylval.nb = atoi(yytext); return NB; }
"X"                { return X; }
"*"                { return MULt; }
"^2"               { return PUIS; }
"+"                { return PLUS; }
[ \t\n]+           
.                  { printf("caractere non reconnu : %s\n", yytext); }
%%
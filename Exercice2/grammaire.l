%option noyywrap
%{
#include "grammaire.tab.h"
%}

%%

"begin"         { return BEGIN; }
"end"        { return END}
"while"         { return WHILE; }
"write"         { return WRITE; }
"read"         { return READ; }
"do"         { return DO; }
"od"         { return OD; }
"int"        {return INT}
">"         { return '>'; }
"<"         { return '<'; }
">="         { return ">="; }
"<="        { return "<="; }
"-"        { return '-'; }
"*"        { return '*'; }
"^"        { return '^'; }
"%"        { return '%'; }
":="        { return ":="; }
"=="        { return "=="; }
"==="        { return "==="; }
"("        { return pg; }
")"        { return pd; }
[0-9]+              { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return ID; }
[ \t\n]+            ;  // ignorer espaces
.                   { printf("Caractère non reconnu : %s\n", yytext); }

%%
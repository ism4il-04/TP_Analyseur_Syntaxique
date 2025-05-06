%option noyywrap
%{
#include "grammaire.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

"begin"         { return deb; }
"end"        { return fin; }
"while"         { return WHILE; }
"write"         { return WRITE; }
"read"         { return READ; }
"do"         { return DO; }
"od"         { return OD; }
"int"        {return INT; }
">"         { return ss; }
"<"         { return si; }
">="         { return se; }
"<="        { return ie; }
":="        { return aff; }
"!="        { return dif; }
"=="        { return eg; }
"==="        { return egg; }
"-"        { return '-'; }
"*"        { return '*'; }
"^"        { return '^'; }
"%"        { return '%'; }
"("        { return pg; }
")"        { return pd; }
[0-9]+              { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.id = malloc(strlen(yytext) + 1);
    if (yylval.id == NULL) {
        printf ("Erreur d'allocation de memoire\n");
        exit(1);
    }
    strcpy(yylval.id, yytext);
    return ID;
}
[ \t\n]+            ;  // ignorer espaces
.                   { printf("Caractere non reconnu : %s\n", yytext); }

%%
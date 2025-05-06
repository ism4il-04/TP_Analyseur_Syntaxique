%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yyerror(const char *msg);
int yylex(void);
%}

%union {
    char* id;
    int num;
}

%token BEGIN END WHILE DO OD READ
%token INT ID NUM
%token '<' '>' "<=" ">=" "==" "===" "!="
%token pg pd
%token '-' '*' '/' '^' ":=" '%'

%left '-'
%left '*' '/' '%'
%right '^'

%start grammaire

%type <num> NUM
%type <id> ID

%%

grammaire   :   BEGIN listinstr END
                ;

listinstr   :   instr listinstr 
                | instr
                ;
instr       :   INT ID
                | ID ':=' expr
                | WRITE expr
                | READ pg ID pd
                | WHILE pg cond pd DO listinstr OD
                ;

expr        :   expr '-' expr
                | expr '*' expr
                | expr '/' expr
                | expr '%' expr
                | expr '^' expr
                | ID
                | NUM
                | pg expr pd
                ;

cond        :   expr condsymb expr

condsymb    :   ">"
                | "<"
                | ">="
                | "<="
                | "!="
                | "=="
                | "==="

%%

int yyerror(const char *msg) {
    fprintf(stderr, "Erreur syntaxique : %s\n", msg);
    return 1;
}

int main() {
    return yyparse();
}
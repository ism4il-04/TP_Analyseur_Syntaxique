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

%token deb fin WHILE DO OD READ WRITE
%token INT ID NUM
%token ss si se ie aff dif eg egg
%token pg pd
%token '-' '*' '/' '^' ":=" '%'

%left '-'
%left '*' '/' '%'
%right '^'

%type <num> NUM
%type <id> ID

%start grammaire

%%

grammaire   :   deb listinstr fin  { printf("Programme valide.\n"); }
                ;

listinstr   :   instr listinstr 
                | instr
                ;
instr       :   INT ID
                | ID aff expr
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

condsymb    :   ss
                | si
                | se
                | ie
                | dif
                | eg
                | egg

%%

int yyerror(const char *msg) {
    fprintf(stderr, "Erreur syntaxique : %s\n", msg);
    return 1;
}

int main() {
    if (yyparse() == 0) {
        printf("Analyse syntaxique réussie.\n");
    }
    getchar(); // bloque l'écran pour lire les messages
    return 0;
    }
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yyerror(const char *message);
int yylex(void);
%}

%union {
    int nb;
}

%token <nb> NB
%token X MULT PUIS PLUS

%start equation

%%

equation:
        NB MULT X PUIS PLUS NB MULT X PLUS NB {
            int a = $1;
            int b = $6;
            int c = $10;

            printf("Equation: %dx^2+%dx+%d", a,b,c);
            float delta = b*b -4*a*c;
            if (delta > 0 ){
                float x1 = (-b + sqrt(delta)) / (2*a);
                float x2 = (-b - sqrt(delta)) / (2*a);
                printf("l'equation admit deux solutions reelles : x1 = %.2f, x2 = %.2f\n", x1, x2);
            } else if (delta == 0) {
                float x = -b / (2*a);
                printf("l'equation admit une solution reelle : x = %.2f\n", x);
            } else {
                printf("l'equation n'admit pas de solution reelle");
            }
        }
;

%%
int main() {
    printf("saisir une equation de second degre ecrite de la forme 'nb * X^2 + nb * X + nb': \n");
    yyparse();
    return 0;
}

int yyerror(const char* message) {
    printf("erreur %s", message);
}
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>  
#include <math.h>

int yylex(void);
int yyerror(const char *message);

%}

%union {
    int nb;
}

%token <nb> NB
%token X '*' PUIS '+'

%start equation

%%

equation:
        NB '*' X PUIS '+' NB '*' X '+' NB {
            int a = $1;
            int b = $6;
            int c = $10;

            printf("Equation: %dx^2+%dx+%d\n", a, b, c);
            float delta = b*b -4*a*c;
            if (a == 0){
                printf("ce n'est pas une equation de deuxieme degree.");
            }else if (delta > 0 ){
                float x1 = (-b + sqrt(delta)) / (2*a);
                float x2 = (-b - sqrt(delta)) / (2*a);
                printf("l'equation admit deux solutions reelles : x1 = %.2f, x2 = %.2f\n", x1, x2);
            } else if (delta == 0) {
                float x = -b / (2.0*a);
                printf("l'equation admit une solution reelle : x = %.2f\n", x);
            } else {
                printf("l'equation n'admit pas de solution reelle");
            }
        }
;

%%

int yylex(void) {
    int c;
    while ((c = getchar()) != EOF) {
        if (isspace(c)) continue;
        if (isdigit(c) || c == '-') {
            int sign = 1;
            if (c == '-') {
                sign = -1;
                c = getchar();
                if (!isdigit(c)) {
                    fprintf(stderr, "Erreur : '-' non suivi d'un chiffre.\n");
                    exit(1);
                }
            }
            ungetc(c, stdin);
            int val;
            scanf("%d", &val);
            yylval.nb = sign * val;
            return NB;
        }
        if (c == 'X') return X;
        if (c == '*') return '*';
        if (c == '+') return '+';
        if (c == '^') {
            c = getchar();
            if (c == '2') return PUIS;
            else {
                fprintf(stderr, "Caractère inattendu après ^ : %c\n", c);
                exit(1);
            }
        }
        fprintf(stderr, "Caractère non reconnu : %c\n", c);
        exit(1);
    }
    return 0;
}

int main() {
    printf("saisir une equation de second degre ecrite de la forme 'nb * X^2 + nb * X + nb': \n");
    yyparse();
    return 0;
}

int yyerror(const char* msg) {
    fprintf(stderr, "Erreur : %s\n", msg);
    return 1;
}

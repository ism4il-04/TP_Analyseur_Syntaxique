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
%token X MULT PUIS PLUS

%start equation

%%

equation:
        NB MULT X PUIS PLUS NB MULT X PLUS NB {
            int a = $1;
            int b = $6;
            int c = $10;

            printf("Equation: %dx^2+%dx+%d\n", a, b, c);
            float delta = b*b -4*a*c;
            if (delta > 0 ){
                float x1 = (-b + sqrt(delta)) / (2*a);
                float x2 = (-b - sqrt(delta)) / (2*a);
                printf("Deux solutions réelles : x1 = %.2f, x2 = %.2f\n", x1, x2);
            } else if (delta == 0) {
                float x = -b / (2.0*a);
                printf("Une solution réelle : x = %.2f\n", x);
            } else {
                printf("Pas de solution réelle\n");
            }
        }
;

%%

int yylex(void) {
    int c;
    while ((c = getchar()) != EOF) {
        if (isspace(c)) continue;
        if (isdigit(c)) {
            ungetc(c, stdin);
            int val;
            scanf("%d", &val);
            yylval.nb = val;
            return NB;
        }
        if (c == 'X') return X;
        if (c == '*') return MULT;
        if (c == '+') return PLUS;
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
    return 0; // fin du fichier
}

int main() {
    return yyparse();
}

int yyerror(const char* msg) {
    fprintf(stderr, "Erreur : %s\n", msg);
    return 1;
}

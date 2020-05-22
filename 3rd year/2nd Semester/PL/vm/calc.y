%{
#include "y.tab.h"
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
int yyerror();
%}

%union {
    int ivalue;
    char cvalue;
}

%%

Calc
    : {printf("pushn 26\nstart\n")} ListaComandos {printf("stop\n");}
    ;

ListaComandos
    : ListaComandos Comando


Print
    : PRINT Exp ';' {printf("writei\n");}
    ;

Read
    : READ id ';' {
        printf("\tpushs \"Introduza um valor: \"\n\twrites\n\tread\n");
        printf("\tstoreg %d\n", $2 - 'a');
    }
    ;

Show
    : SHOW ';' {
        for(int i = 0; i < 26; i++)
            printf("\tpushg %d\n\twritei\n", )
    }
    ;

Halt
    : HALT ';' {printf("stop\n");}
    ;

Atrib
    : id '=' Exp ';' {
        printf("\tstoreg %d\n", $1 - 'a');
    }
    ;

Exp
    : Exp '+' Termo {printf("\tadd\n");}
    | Exp '-' Termo {printf("\tadd\n");}
    | Termo
    ;

Termo
    : Termo '/' Fator {
        if($3 == 0) erroSem("DIVISÃO POR 0");
        else printf("\tdiv\n");
    }
    | Termo '*' Fator {printf("\tmul\n");}
    | Fator
    ;

Fator
    : id {printf("\tpushg %d\n", $1 - 'a');}
    | num {printf("\tpushi %d\n", $1);}
    | '(' Exp ')'
    ;

%%

int main() {
    yyparse();
    return 0;
}

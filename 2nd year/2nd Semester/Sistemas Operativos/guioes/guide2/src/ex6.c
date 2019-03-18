#include "guide2.h"
#define COLUNAS 100
#define LINHAS 10

void povoaMatriz(int matriz[10][100]) {
    int ground = 0;
    int ceiling = 10;
    srand(time(NULL));
    for(int i = 0; i < LINHAS; i++)
        for(int j = 0; j < COLUNAS; j++)
            matriz[i][j] = rand() % (ceiling + 1 - ground) + ground;
}

int main(int argc, char **argv) {
    int alvo;
    int matrix[LINHAS][COLUNAS];
    alvo = atoi(argv[1]);
    povoaMatriz(matrix);
    // podemos ir guardando o `processID` dos filhos num array
    int childs[LINHAS];
    for(int i = 0; i < LINHAS; i++) {
        if(!(childs[i] = fork())) {
            for(int j = 0; j < COLUNAS; j++) {
                if(matrix[i][j] == alvo) _exit(1);
            }
            _exit(0);
        }
    }
    pid_t pid;
    int status;
    while((pid = wait(&status)) != -1) {
        int i;
        // temos de fazer um pequeno ciclo para descobrir a linha do processo que acabou
        for(i = 0; i < LINHAS && pid != childs[i]; i++);
        // temos agora a linha do processo que acabou
        // vamos descobrir que valor retornou ao pai quando acabou
        // caso tenha retornado `1` encontrou o `alvo`, caso contrário retornou `0`
        if(WEXITSTATUS(status)) printf("O processo %d encontrou o alvo na linha %d\n", pid, i);
    }
    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <time.h>



void matrix_vector_produto(double** A, double *x, double *b, int *n, int *m) {
    for (int i = 0; i < (*n); i++) {
        for (int j = 0; j < (*m); j++) {
            b[i] += A[i][j] * x[j];
        }
    }
}

void matrix_vector_produto_invertido(double** A, double *x, double *b, int *n, int *m) {
    for (int j = 0; j < (*m); j++) {
        for (int i = 0; i < (*n); i++) {
            b[i] += A[i][j] * x[j];
        }
    }
}

int main(){

    srand(time(NULL));
    int n_max = 10000;
    int m_max = 10000;
    int n, m;
    clock_t start, end;
    double cpu_time_used1, cpu_time_used2;
    FILE* f = fopen("resultados_c.txt", "w");
    
    for (int k = 1; k <= 10; k++) {
        n = k * n_max / 10;
        m = k * m_max / 10;
        double** A = (double**) malloc(n * sizeof(double*));
        if (A == NULL) {
            printf("Erro ao alocar memória para A!\n");
            return 1;
        }

        double *x = (double *) malloc(m * sizeof(double));
        if (x == NULL) {
            printf("Erro ao alocar memória para x!\n");
            for (int i = 0; i < n; i++) {
                free(A[i]);
            }
            free(A);
            return 1;
        }

        double *b = (double *) malloc(m * sizeof(double));
        if (b == NULL) {
            printf("Erro ao alocar memória para b!\n");
            for (int i = 0; i < n; i++) {
                free(A[i]);
            }
            free(A);
            free(x);
            return 1;
        }


        for (int i = 0; i < n; i++){
            A[i] = (double*) malloc(m * sizeof(double));
            for (int j = 0; j < m; j++){
                A[i][j] = ((double)rand()/(double)RAND_MAX) * 10.0 - 5.0;
            }
            b[i] = 0;
            x[i] = (double) rand() / RAND_MAX;
        }

   
    // Loop aninhado padrão: i, j
    start = clock();
    matrix_vector_produto(A, x, b, &n, &m);
    end = clock();
    cpu_time_used1 = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Matriz %dx%d: Tempo de execução com loop aninhado padrão (i,j): %lf segundos\n", n, m, cpu_time_used1);

    // Loop aninhado invertido: j, i
    start = clock();
    matrix_vector_produto_invertido(A, x, b, &n, &m);
    end = clock();
    cpu_time_used2 = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Matriz %dx%d: Tempo de execução com loop aninhado invertido (j,i): %lf segundos\n\n", m, n, cpu_time_used2);

    
    fprintf(f, "%dx%d %d %lf %lf\n", n, m, k, cpu_time_used1, cpu_time_used2);

    // liberando memória alocada
    for (int i = 0; i < n; i++) {
        free(A[i]);
    }
    free(A);
    free(b);
    free(x);
    }
    fclose(f);
    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void matrix_vector_product(int n, int m, double A[n][m], double x[m], double b[n]) {
    for (int i = 0; i < n; i++) {
        b[i] = 0;
        for (int j = 0; j < m; j++) {
            b[i] += A[i][j] * x[j];
        }
    }
}

int main() {
    srand(time(NULL));
    int n_max = 10000;
    int m_max = 10000;
    int n, m;
    double *A, *x, *b;
    clock_t start, end;
    double cpu_time_used;

    for (int k = 1; k <= 10; k++) {
        n = k * n_max / 10;
        m = k * m_max / 10;
        A = (double *) malloc(n * m * sizeof(double));
        x = (double *) malloc(m * sizeof(double));
        b = (double *) malloc(n * sizeof(double));
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                A[i * m + j] = (double) rand() / RAND_MAX;
            }
        }
        for (int j = 0; j < m; j++) {
            x[j] = (double) rand() / RAND_MAX;
        }
        start = clock();
        matrix_vector_product(n, m, (double (*)[m]) A, x, b);
        end = clock();
        cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
        printf("%d,%d,%lf\n", n, m, cpu_time_used);
        free(A);
        free(x);
        free(b);
    }
    return 0;
}
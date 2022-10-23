#include <stdio.h>

extern void func(int* a, int* b, int i, int n);

int main(int argc, char* argv[]) 
{
    FILE *input, *output;
    int i, n;
    int A[100];
    int B[100];
    input = fopen("input.txt", "r");
    for (i = 0; i < 1; ++i) 
    {
	fscanf(input, "%d", &n);
    }
    for (i = 0; i < n; ++i)
    {
        fscanf(input, "%d", &A[i]);
    }
    fclose(input);
    func(A, B, i, n);
    output = fopen("output.txt", "w");
    for (i = 0; i < n; ++i)
    {
        fprintf(output, "%d ", B[i]);
    }
    fclose(output);
    return 0;
}

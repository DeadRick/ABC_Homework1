#include <stdio.h>

extern void func(int* a, int* b, int i, int n);
extern void print(int *b, const int n, int i);

int main(int argc, char* argv[]) 
{
    int i, n;
    int A[100];
    int B[100];
    scanf("%d", &n);
    for(i=0;i<n;i++) 
    {
        scanf("%i",&A[i]);
    }

    func(A, B, i, n);
    print(B, n, i);
    return 0;
}

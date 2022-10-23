#include <stdio.h>

void print(int *b, const int n, int i)
{
    for(i=0;i<n;i++) 
    {
        printf("%d ",b[i]);
    }
}

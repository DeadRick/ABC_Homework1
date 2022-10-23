#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void func(int* a, int* b, int i, int n);

int64_t timespecDiff(
    struct timespec timeA,
    struct timespec timeB
)
{
    int64_t nsecA, nsecB;

	nsecA = timeA.tv_sec;
    nsecA *= 1000000000;
	nsecA += timeA.tv_nsec;

	nsecB = timeB.tv_sec;
	nsecB *= 1000000000;
	nsecB += timeB.tv_nsec;
	
	return nsecA - nsecB;
}

int main(int argc, char** argv) 
{
    char* arg;
    int i, n, seed;
	struct timespec start;
	struct timespec end;
	int64_t elapsed_ns;
    if (argc == 2) 
    {
		arg = argv[1];
		seed = atoi(arg);
		srand(seed);
    } else {
		return 1;
    }
    int A[100];
    int B[100];
    clock_gettime(CLOCK_MONOTONIC, &start);
    n = 5;
    for(i=0;i<n;i++) 
    {
        A[i] = rand();
    }
    func(A, B, i, n);
	clock_gettime(CLOCK_MONOTONIC, &end);
	elapsed_ns = timespecDiff(end, start);
	printf("Elapsed: %ld ns", elapsed_ns);
    return 0;
}

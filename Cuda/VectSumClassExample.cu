#include "cuda_runtime.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define N (4096*4096)
#define THREADS_PER_BLOCK 512

__global__ void sumOnGpu(int *a, int *b, int *c, int n){
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	if(index < n){
		c[index] = a[index] + b[index];
	}
}

void sumOnCpu(int *a, int *b, int *c, int n){
	for(int i = 0; i < n; i++){
		c[i] = a[i] + b[i];
	}
}

void randomNumbers(int *a, int n){
	for(int i = 0; i < n; i++){
		a[i] = rand()%100000;
	}
}

int compare(int *a, int *b, int n){
	int pass = 1;
	for(int i = 0; i < n; i++){
		if(a[i] != b[i]){
			printf("Different values at a[%i] = %i and b[%i] = %i \n", i, a[i], i, b[i]);
			pass = 0;
		}
	}
	if (pass)
		printf("args are the same \n");
	else
		printf("args are different \n");
	return pass;
}


int main(){
	int *a, *b, *c;
	int *d_a, *d_b, *d_c;
	int size = N * sizeof(int);

	a = (int*)malloc(size);
	b = (int*)malloc(size);
	c = (int*)malloc(size);

	cudaMalloc((void**)&d_a, size);
	cudaMalloc((void**)&d_b, size);
	cudaMalloc((void**)&d_c, size);

	randomNumbers(a, N);
	randomNumbers(b, N);

	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

	clock_t timeOnGpu = clock();

	sumOnGpu<<<N/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_a, d_b, d_c, N);

	printf("time on GPU %f \n", ((double)clock() - timeOnGpu)/CLOCKS_PER_SEC);

	cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

	int* c_h;
	c_h = (int*)malloc(size);

	clock_t i = clock();

	sumOnCpu(a, b, c_h, N);
	printf("time on CPU %f \n", ((double)clock() - i)/CLOCKS_PER_SEC);

	compare(c, c_h, N);
	free(a);
	free(b);
	free(c);
	free(c_h);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

	return 0;

}

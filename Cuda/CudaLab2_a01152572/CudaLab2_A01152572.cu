/*
•       Implement a matrix multiplication using a GPU to solve the operation instead of a CPU. Create the matrices in the CPU pass them to the GPU calculate the answer and show the answer in the console in an ordered way.
*/
#include "cuda_runtime.h"
#include <stdio.h>
#include <stdlib.h>  // rand(), srand()
#include <time.h>

__global__ void gpuMatrix(int *m1, int *m2, int *m3, int dim) {
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  int temp = 0;

  int row = tid/dim;
  int col = tid % dim;

  if(col < dim && row < dim){
    for (int i = 0; i < dim; i++) {
      temp += m1[row*dim+i]*m2[i*dim+col];
    }
   m3[tid] = temp;
  }
}
// void cpuMatrix(){
//   int m1[10][10], m2[10][10], sum[10][10];
//   int m = 10;
//   int n = 10;
//
//   int (*a)[m][n];
//   int (*b)[m][n];
//
//   printf("First matrix\n");
//   for (int i = 0; i < m; i++) {
//     for (int j = 0; j < n; j++) {
//       m1[m][n]= (rand() % 9) + 1;
//       printf("%d  ", m1[m][n]);
//
//     }
//     printf("\n");
//   }
//
//   printf("\nSecond matrix\n");
//   for (int i = 0; i < m; i++) {
//     for (int j = 0; j < n; j++) {
//       m2[m][n]= (rand() % 9) + 1;
//       printf("%d  ", m2[m][n]);
//
//     }
//     printf("\n");
//   }
//
//   a = &m1;
//   b = &m2;
//
// }


// void print_matrix(int *m, int n){
// 	for(int i = 0; i < n; i++){
// 		printf("%d\t", m[i]);
// 		if (i % n == n-1)
// 		{
// 			printf("\n");
// 		}
// 	}
//
// 	printf("\n");
// }

void fillMatrixGpu(int *m, int n){
  for (int i = 0; i < n; i++) {
          m[i] = rand()%9+1;
  }
}
int main(){
  int dim = 4;
  int threadsPerBlock = 4;
  int *m1, *m2, *m3;
  int *d_m1, *d_m2, *d_m3;
  int size = dim*dim*sizeof(int);

  // allocate dev
  cudaMalloc((void**)&d_m1, size);
  cudaMalloc((void**)&d_m2, size);
  cudaMalloc((void**)&d_m3, size);

  // allocate host
  m1 = (int*)malloc(size);
  m2 = (int*)malloc(size);
  m3 = (int*)malloc(size);

  // run clock()
  clock_t timeOnGpu = clock();

  //fillMatrix
  fillMatrixGpu(m1, dim*dim);
          fillMatrixGpu(m2, dim*dim);

  for(int i = 0; i < dim; i++){
     for(int j = 0; j < dim; j++){
        printf("%d\t",  m1[i + j * dim]);
          }
        printf("\n");
        }
        printf("\n");
  for(int i = 0; i < dim; i++){
     for(int j = 0; j < dim; j++){
                        printf("%d\t",  m2[i + j* dim]);
          }
        printf("\n");
        }
        printf("\n");
  //host to device
  cudaMemcpy(d_m1, m1, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_m2, m2, size, cudaMemcpyHostToDevice);

  // Kernel function
  gpuMatrix<<<dim*dim/threadsPerBlock, threadsPerBlock>>> (d_m1, d_m2, d_m3, dim);
  //device to host
  cudaMemcpy(m3, d_m3, size, cudaMemcpyDeviceToHost);

  //print result and time
  for(int i = 0; i < dim; i++){
     for(int j = 0; j < dim; j++){
        printf("%d\t",  m3[i + j * dim]);
          }
        printf("\n");
        }
  printf("time on GPU %f \n", ((double)clock() - timeOnGpu)/CLOCKS_PER_SEC);

  //free memory
  cudaFree(d_m1);
  cudaFree(d_m2);
  cudaFree(d_m3);

  free(m1);
  free(m2);
  free(m3);

  // clock_t timeOnCpu = clock();
  // cpuMatrix();
  // printf("time on CPU %f \n", ((double)clock() - timeOnCpu)/CLOCKS_PER_SEC);

  return 0;
}

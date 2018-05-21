/*
    Author Javier Rodríguez
           A01152572
*/

#include "cuda_runtime.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define N (1000000)
#define THREADS_PER_BLOCK 1000

//pi on cpu
double getPiCpu(){
  long num_rects = N, i;
  double mid, height, width, area;
  double sum = 0.0;

  width = 1.0 / (double) num_rects;

  for (i = 0; i < num_rects; i++) {
    mid = (i + 0.5) * width;
    height = 4.0 / (1.0 + mid * mid);
    sum += height;
  }
  area = width * sum;
  return area;

}

//Pi gpu
__global__ void getPiGpu(double *a, long n) {
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  //Pi variables
  double mid, width;

  width = 1.0 / (long) n;

        if(tid < n){
          mid = (tid + 0.5) * width;
          a[tid] = 4.0 / (1.0 + mid * mid);
          }
      }

      // double piSum(double *a){
      //   double sum, width, pi;
      //   long num_rects = N;
      //
      //   width = 1.0 / (double) num_rects;
      //
      //   for (long i = 0; i < N; i++) {
      //       sum += a[i];
      //   }
      //     pi = width * sum;
      //     return pi;
      // }

      int main() {
        double piCpu, piGpu;
        double sum, width;
        double a[N];
        double *d_a;
        double size = N * sizeof(double);

        d_a=(double*)malloc(size);
        cudaMalloc((void**)&d_a, size);
        //time on gpu
        clock_t timeOnGpu = clock();
        //kernel call
        getPiGpu<<<N/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_a, N);
        //devicetohost recuperar array de heights
        cudaMemcpy(a, d_a, size, cudaMemcpyDeviceToHost);
        cudaFree(d_a);
        // piGpu = piSum(a[N]);
        width = 1.0 / (double) N;

        for (long i = 0; i < N; i++) {
           sum += a[i];
        }

        piGpu = width * sum;

        printf("%f\n", piGpu);
                printf("time on GPU %f \n", ((double)clock() - timeOnGpu)/CLOCKS_PER_SEC);

        //Get pi cpu and print
        clock_t timeOnCpu = clock();
        piCpu = getPiCpu();
        printf("%lf\n", piCpu);
        printf("time on CPU %f \n", ((double)clock() - timeOnCpu)/CLOCKS_PER_SEC);
                return 0;
        }


// #include "cuda_runtime.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define N (4096*4096)
#define THREADS_PER_BLOCK 512

__global__ void getPiGpu(int *a, int n) {
  int index = threadIdx.x + blockIdx.x * blockDim.x;
  long num_rects = 1000000000, i;
  double mid, height, width, area;
  double sum = 0.0;

	if(index < n){
    width = 1.0 / (double) num_rects;

    for (i = 0; i < num_rects; i++) {
      mid = (i + 0.5) * width;
      height = 4.0 / (1.0 + mid * mid);
      sum += height;
    }
    area = width * sum;
    return area;

	}
}

double getPiCpu(){
  long num_rects = 1000000000, i;
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

int main() {
  float piCpu;


  clock_t timeOnCpu = clock();
  piCpu = getPiCpu();
  printf("%f\n", piCpu);
  printf("time on CPU %f \n", ((double)clock() - timeOnCpu)/CLOCKS_PER_SEC);
  return 0;
}

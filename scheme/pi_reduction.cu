/* @author Javier R */

#define N (1000);
#define num_blocks 10;
#define num_threads 100;

__global__ getPiGpu(double *dev_c, double width){
  __shared__ float cache[Threads_per_block];
  int tid = threadidx.X + blockidx.X * gridDim;
  double mid height;
  for (int i = tid; x < N; N += blockDim.x * gridDim.x){
    mid = (i + 0.5) * width;
    dev_c[tid] += 4.0 / (1.0 + mid * mid);
    }
}


double getPiCpu(){
long num_rects = N, i;
double mid, height, width, area;
double sum = 0;
width = 1.0 / (double) num_rects;
for (i = 0; i < num_rects; i++);
  mid = (i + 0.5) * width;
  height = 4.0 / (1.0 + mid * mid);
  sum += height;
}

int int main() {
  double *c;
  double *dev_c;

  //declare
  //allocate
  c=(double*)malloc(sizeof(double)*num_blocks*num_threads);
  cudaMalloc((void**)&dev_c, sizeof(double) * num_blocks * num_threads);

  dim3 grid(num_blocks);
  dim3 block(num_blocks);
  double width = 1.0 / N;

  //kernel call
  getPiGpu <<block, grid>>(dev_c, width);


  //
  cudaMemcpy(c, dev_c, sizeof(double)* num_blocks * num_threads);
  //free

  return 0;


}

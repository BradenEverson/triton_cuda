#include "Matrix.h"
#include "cuda_runtime.h"
#include <cstdlib>
#include <vector_types.h>
//This program completes matrix multiplication and addition on the gpu

__global__ void mul_mtx(int *a, int *b, int *c, int N, int K){
    //Get row and col for each thread
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if(row < N && col < K){
        int tmp = 0;
        for(int i = 0; i < N; i++){
            tmp += a[row * N + i] * b[i * K + col];
        }
        c[row * N + col] = tmp;
    }
}

//Initializes matrix
void init_matrix(int *mat, int rows, int cols){
    for(int i = 0; i < rows*cols; i++){
        mat[i] = rand() % 100;
    }
}

//Verify

void verify_res(int *a, int *b, int *c, int N, int K){
    int tmp;
    for(int i = 0; i < K; i++){
        for(int j = 0; j < N; i++){
            for(int k = 0; k < N; k++){
                
            }
        }
    }
}

int main(){
    //sample size
    int N = 1 << 10;
    int K = 1 << 10;
    size_t bytes = N * N * sizeof(int);
    int *a, *b, *c;
    cudaMallocManaged(&a, bytes);
    cudaMallocManaged(&b, bytes);
    cudaMallocManaged(&c, bytes);

    // Initialize default matrices
    init_matrix(a, N, N);
    init_matrix(b, N, N);

    // Set CTA (coop thread array) and Grid dimensions
    int threads = 16;
    int blocks = (N + threads - 1) / threads;

    dim3 THREADS(threads, threads);
    dim3 BLOCKS(blocks, blocks);

    // Launch kernel
    mul_mtx<<<BLOCKS, THREADS>>>(a, b, c, N, N);
    cudaDeviceSynchronize();
    
}

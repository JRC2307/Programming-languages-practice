package com.matSum;


public class Addmat implements  Runnable
{
    private int [][] mat1;
    private int [][] mat2;
    private int [][] mat3;
    int begin; 
    private int end;

    public Addmat(int[][] m1, int[][] m2, int[][] m3, int b, int e){
        mat1 = m1;  mat2 = m2;  mat3 = m3;  begin = b;  end = e;
    }

    @Override
    public void run() {
        for(int i = 0; i< end; i++){
            for(int j = 0; j< end; j++){
                mat3[i][j] = mat3[i][j] +  mat1[i][j]+mat2[i][j];
            }
        }
    }
}

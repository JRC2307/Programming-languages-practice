package com.matSum;

public class Test {
    public static void main(String args[]){
        // filling the matrix to test the code
        int start = 0 , end = 2;
        int[][]  matA= new int[end][end];
        int[][]  matB= new int[end][end];
        int[][]  matResult= new int[end][end];

        for(int i = 0; i< end; i++){
            for(int j = 0; j< end; j++){
                matA[i][j]= 1; matB[i][j]= 1;  matResult[i][j] = 0;
            }
        }
        // filling the matrix to test the code
        try {
        Addmat add1 = new Addmat(matA, matB, matResult, 0, (end/2)+1);
        Addmat add2 = new Addmat(matA, matB, matResult, (end/2)+1, end);

        Thread t1 = new Thread(add1);
        Thread t2 = new Thread(add2);

        t1.start();
        t2.start();
        t1.join();
        t2.join();

      }catch(InterruptedException ex){

      }


        for(int i = 0; i< end; i++){
            for(int j = 0; j< end; j++){
                System.out.print(" " + matResult[i][j]+ " ");
            }
            System.out.print(Thread.currentThread() + "\n");
        }
    }
}

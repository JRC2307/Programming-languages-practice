package com.examples.arg;

public class ArgExample {

  public static class ArrayInc implements Runnable {
    int[] arg;
    int start;
    int end;

    public ArrayInc(int[] a, int s, int e){
      arg = a;
      start = s;
      end = e;
    }

    @Override
    public void run() {
      for (int i = start; i < end ; i ++) {
        arg[i]++;
      }
    }
  }

  public static void main(String args[]){
    int n = 10;
    int[] a = new int[n];
    for(int i = 0; i < n; i++){
      a[i]=0;
    }
    (new Thread(new ArrayInc((a), 0, n/2))).start();
    (new Thread(new ArrayInc((a), n/2, n))).start();
    try{
      Thread.sleep(1000);
    }catch(InterruptedException e){

    }
    for (int i = 0; i < n ; ) {
      System.out.println(" " + a[i]);
    }
    System.out.println("cores" + Runtime.getRuntime().availableProcessors());
  }
}

package com.examples.colorSynch;

public class SynchExample{

  private static class RGBChecker implements Runnable {
    SynchronizedRGB color;
    public RGBChecker(SynchronizedRGB c){
      color = c;
    }

    @Override
    public void run(){
      for (int i = 0; i < 50; i++) {
        try{
          int myColorInt = color.getRGB();
          Thread.sleep(1);
          String myColorName = color.getName();
          System.out.println("Current color" + myColorInt + "current name: " + myColorName);
        }catch(InterruptedException e){
          System.out.println("Bummer");
        }
      }
    }
  }

  private static class RGBWhite implements Runnable{
      SynchronizedRGB color;
      public RGBWhite(SynchronizedRGB c){
        color = c;
      }
      @Override
      public void run() {
        for (int i = 0 ; i <10000000; i++) {
          color.set(255,255,255,"white");
          }
        }
      }
      private static class RGBBlack implements Runnable{
          SynchronizedRGB color;
          public RGBBlack(SynchronizedRGB c){
            color = c;
          }
          @Override
          public void run() {
            for (int i = 0 ; i <10000000; i++) {
              color.set(255,255,255,"black");
              }
            }
          }

    public static void main(String args[]){
    SynchronizedRGB color = new SynchronizedRGB(0,0,0,"black");
    RGBBlack black = new RGBBlack(color);
    RGBWhite white = new RGBWhite(color);
    RGBChecker check = new RGBChecker(color);

    (new Thread(white)).start();
    (new Thread(black)).start();
    (new Thread(check)).start();
    }
}

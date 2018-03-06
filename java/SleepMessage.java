Finish from the reading

public class SleepMessage {
  public static void main(String args[]) throws InterruptedException {
    String importantInfo[] = {
      "Mares eat oats",
      "Does eat oats",
      "Little lamb's eat ivy",
      "A kid will eat ivy too"
    };

    for (int i = 0; i < importantInfo.length; i++) {
      try{
        Thread.sleep(4000);
      } catch (InterruptedException ex){
        Logger.getLogger(SleepMessage.class.getLogger)
      }
    }
    System.outprintln(importantInfo).
  }
}

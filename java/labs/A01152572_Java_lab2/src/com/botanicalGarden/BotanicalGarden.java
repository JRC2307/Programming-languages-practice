package com.botanicalGarden;
import java.util.Random;
/**
 *
 * @author Javier Rodríguez
 */
public class BotanicalGarden{
    public int capacity;
    public int guestCounter;
    String name;

    //Construct
    public BotanicalGarden( int people, String name )
    {
        this.capacity = capacity;
        this.name = name;
    }

    public String getName()
    {
        return name;
    }

   private static class West implements Runnable{
   		SynchronizedCounter counter;

		public West(SynchronizedCounter c){
			counter = c;
		}
		@Override
		public void run() {
			for(int i = 0; i<100; i++){
				counter.increment();

			}
			System.out.println(Thread.currentThread() + "People count:" + counter.value());
		}
   }

    private static class East implements Runnable{
    		SynchronizedCounter counter;

		public East(SynchronizedCounter c){
			counter = c;
		}
		@Override
		public void run() {
			for(int i = 0; i<100; i++){
				counter.increment();

			}
			System.out.println(Thread.currentThread() + "People count:" + counter.value());
		}
    }
    public static class SynchronizedCounter {
        private int c = 0;

        public synchronized void increment() {
            c++;
        }

        public synchronized void decrement() {
            c--;
        }

        public synchronized int value() {
            return c;
        }
    }

	public static void main(String [] args){

            try {
		SynchronizedCounter count = new SynchronizedCounter();
		East tca = new East(count);
		West tcb = new West(count);

		Thread ta = new Thread (tca);
		Thread tb = new Thread (tcb);

                System.out.println("Welcome to Mexico's City Botanical Garden");
                System.out.println("Showing people log: ");

		ta.start();
		tb.start();

		ta.join();
		tb.join();

		}catch(InterruptedException ex){

		}

}


}

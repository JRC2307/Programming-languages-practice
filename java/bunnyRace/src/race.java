
import java.util.Random;

public class race implements Runnable {

    private String name;
    private int mts;

    public String getName() {
        return name;
    }

    public race(String name, int feet) {
        this.name = name;
        this.mts = feet;
    }

    public static int rabbitSpeed() {
        Random rand = new Random();
        int Result = rand.nextInt(500) + 500;
        return Result;
    }

    public static int turtleSpeed() {
        Random rand = new Random();
        int Result = rand.nextInt(7) + 3;
        return Result;
    }

    @Override
    public void run() {

        int feet = 0;
        int rest = 0;
        Thread t = Thread.currentThread();
        t.setName(name);

        while (t.isAlive()) {

            if (t.getName().equals("Rabbit")) {

                if (rest == 0) {
                    feet += mts * rabbitSpeed();
                    rest = 1;
                    if (feet > 10000) {
                        feet = 10000;
                    }
                    System.out.println(this.name + ": " + feet);

                } else {
                    rest = 0;
                    try {
                        Random rand = new Random();
                        int Result = rand.nextInt(100) + 100;
                        Thread.sleep(Result);
                    } catch (InterruptedException ex) {
                        return;
                    }
                }

            } else if (t.getName().equals("Turtle")) {
                feet += mts * turtleSpeed();
                if (feet > 10000) {
                    feet = 10000;
                }

                System.out.println(this.name + ": " + feet);
                try {
                    Thread.sleep(1);
                } catch (InterruptedException ex) {
                    return;
                }

            }
            if (feet >= 10000) {
                System.out.println(this.name + ": Finished the race!");
                Main.finished(t);
                return;
            }
        }
    }

}

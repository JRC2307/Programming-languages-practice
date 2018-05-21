public class main {

    static Thread turtle = new Thread(new Race("Turtle", 1));
    static Thread rabbit = new Thread(new Race("Rabbit", 1));

    public static void main(String[] args) {
        turtle.start();
        rabbit.start();

    }

    synchronized public static void finished(Thread winner) {
        if (winner.isInterrupted()) {
            return;
        }

        if (winner.getName().equals("Rabbit")) {
            turtle.interrupt();
        } else if (winner.getName().equals("Turtle")) {
            rabbit.interrupt();
        }
    }

}
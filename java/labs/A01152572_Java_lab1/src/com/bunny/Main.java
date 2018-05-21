/**
 * @author   Javier Rodriguez C A01152572
 * @version  0.1.0
 * @since    6/3/2018
 * @param
 * @return
 * @see
*/
package com.bunny;

public class Main {

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

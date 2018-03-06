

Public class simpleThread implements Runnable {
    int Id;

    public simpleThread(int id){
        Id = id;
    }

    public void run() {
       for (int i = 0; i<1000; i++)
            System.out.println("Hello from" + Id)
    }

    public static void main(String args[], throws InterruptedException) {
        (new Thread(new simpleThread(1))).start();
        simpleThread run1 = new simpleThread(1);
        simpleThread run2 = new simpleThread(2);
        simpleThread run3 = new simpleThread(3);
        Thread t1 = new Thread(run1);
        Thread t2 = new Thread(run2);
        Thread t3 = new Thread(run3);
        System.out.println("Start"+ t1.getId());
        t1.start();
        System.out.println("Start"+ t2.getId());
        t2.start();
        System.out.println("Start"+ t3.getId());
        t3.start();
        t1.join();
        t2.join();
        t3.join();
        System.out.println("All threads are finished");


    }
}
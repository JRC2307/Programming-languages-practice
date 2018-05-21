package com.greyParallel;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;
/**
*
* @author LuisAcosta
*/
public class Grey extends RecursiveTask<BufferedImage> {

  static BufferedImage image;
  int start, end;
  Grey(int start, int end) {
    this.start = start;
    this.end = end;
  }

  protected BufferedImage compute() {
    int numRows = image.getHeight();

    if (end - start <= 10000) {
      for (int i = 0; i < numRows; i++) {
        for (int j = start; j < end; j++) {
          int rgb = image.getRGB(j, i);
          int red = rgb & 0xFF;
          int green = (rgb >> 8) & 0xFF;
          int blue = (rgb >> 16) & 0xFF;// para juntar hay que usar corrimientos opuestos y Ors
          rgb = ~rgb; // ~ es negacion
          image.setRGB(j, i, rgb);
        }
      }
      return image;
    } else {
      int mid = (start + end) / 2;
      Grey t1, t2;
      t1 = new Grey(start, mid);
      t2 = new Grey(mid + 1, end);
      t1.fork();
      return t2.compute();
    }

  }

  private static void convertor(BufferedImage image) {
    Grey imgSize = new Grey(0, image.getWidth());
    ForkJoinPool pool = new ForkJoinPool();
    pool.invoke(imgSize);
    pool.shutdown();
  }

  public static void main(String[] args) throws IOException {
    //parallel conversion
    System.out.println("\nParallel conversion...");
    image = ImageIO.read(
    new File("/Users/J/10Semestre/ProgrammingLanguages/code/Programming-languages-practice/java/greyImage/src/com/greyParallel/camera.jpg"));

    double start = System.nanoTime();
    convertor(image);
    double conversionTimeParallel = (double) ((System.nanoTime()) - start) / 1000000000; //Divide by 1^9 for time in seconds
    System.out.println("Parallel conversion time: " + conversionTimeParallel);

    ImageIO.write(image, "jpg", new File("/Users/J/10Semestre/ProgrammingLanguages/code/Programming-languages-practice/java/greyImage/src/com/greyParallel/cameraPL.jpg"));


    //sequential conversion
    System.out.println("\nSequential conversion...");
    BufferedImage image2 = ImageIO.read(new File("/Users/J/10Semestre/ProgrammingLanguages/code/Programming-languages-practice/java/greyImage/src/com/greyParallel/camera.jpg"));
    double start2 = System.nanoTime();
    int numRows = image2.getHeight();
    int numCols = image2.getWidth();
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        int rgb = image2.getRGB(j, i);
        int red = rgb & 0xFF;
        int green = (rgb>> 8) & 0xFF;  // >> son corrimientos de  Bits el & hace un 0000000111 con el numero por lo que borra todo menos lo que quede  con 1s
        int blue = (rgb>>16) & 0xFF; // para juntar hay que usar corrimientos opuestos y Ors
        rgb = ~rgb; // ~ es negacion
        image2.setRGB(j, i, rgb); // sets los pixeles de colores
      }
    }
    ImageIO.write(image2, "jpg",
    new File("/Users/J/10Semestre/ProgrammingLanguages/code/Programming-languages-practice/java/greyImage/src/com/greyParallel/cameraGreyNP.jpg"));
    double conversionTimeSeq = (double) ((System.nanoTime()) - start2) / 1000000000;
    System.out.println("Sequential conversion time: " + conversionTimeSeq);

    System.out.println("\nAll Done!");
  }


}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lab3_a00958934;

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
public class ImageConvertor extends RecursiveTask<BufferedImage> {

    static BufferedImage image;//this
    int start, end;

    ImageConvertor(int start, int end) {//this
        this.start = start;
        this.end = end;
    }

    protected BufferedImage compute() {
        int numRows = image.getHeight();

        if (end - start <= 10000) {
            for (int i = 0; i < numRows; i++) {
                for (int j = start; j < end; j++) {
                    int rgb = image.getRGB(j, i);

                    // >> son corrimientos de  Bits el & hace un 0000000111 con el número por lo que borra
                    int red = rgb & 0xFF;
                    int green = (rgb >> 8) & 0xFF;
                    int blue = (rgb >> 16) & 0xFF;// para juntar hay que usar corrimientos opuestos y Ors

                    rgb = ~rgb; // ~ es negacion
                    image.setRGB(j, i, rgb);
                }
            }
            return image;
        } else {
            int mid = (start + end) >>> 1;
            ImageConvertor t1, t2;

            t1 = new ImageConvertor(start, mid);
            t2 = new ImageConvertor(mid + 1, end);
            t1.fork();
            return t2.compute();

        }

    }

    public static void main(String[] args) throws IOException {

        System.out.println("Performing Sequential conversion...");
        BufferedImage image2 = ImageIO.read(
                new File("/Users/LuisAcosta/Desktop/camera.jpg"));
        //Time for sequential starts here
        double start = System.nanoTime();

        int numRows = image2.getHeight();
        int numCols = image2.getWidth();

        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
                int rgb = image2.getRGB(j, i);
                int red = rgb & 0xFF;
                int green = (rgb >> 8) & 0xFF;
                int blue = (rgb >> 16) & 0xFF;
                rgb = ~rgb;
                image2.setRGB(j, i, rgb);
            }
        }
        ImageIO.write(image2, "png",
                new File("/Users/J/Desktop/1er Parcial/Lab3_Parallelism/camera.jpg"));
        //Time count ends for sequential conversion
        double conversionTime = (double) ((System.nanoTime()) - start) / 1000000000; //Divide by 1e9 since its in nanoseconds
        System.out.println("Sequential conversion finished" + "\nTime: " + conversionTime);

        System.out.println("\nPerforming Parallel conversion...");
        image = ImageIO.read(
                new File("/Users/LuisAcosta/Desktop/camera.jpg"));

        double start2 = System.nanoTime();
        ConvertorTask(image);
        double conversionTime2 = (double) ((System.nanoTime()) - start2) / 1000000000; //Divide by 1e9 since its in nanoseconds
        System.out.println("Parallel conversion finished" + "\nTime: " + conversionTime2);

        ImageIO.write(image, "jpg",
                new File("/Users/J/Desktop/1er Parcial/Lab3_Parallelism/camera.jpg"));
        System.out.println("\nFinished conversions!");
    }

    private static void ConvertorTask(BufferedImage image) {
        ImageConvertor imgSize = new ImageConvertor(0, image.getWidth());
        ForkJoinPool pool = new ForkJoinPool();
        pool.invoke(imgSize);
        pool.shutdown();
    }
}

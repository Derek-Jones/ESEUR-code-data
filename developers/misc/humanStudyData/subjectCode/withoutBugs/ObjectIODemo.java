package ch10;
import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileNotFoundException;

/**
 Demonstrates binary file I/O of serializable class objects.
*/
public class ObjectIODemo
{

   public static void main(String[] args)
   {

      try
      {
          ObjectOutputStream outputStream =
             new ObjectOutputStream(new FileOutputStream("datafile"));

          SomeClass oneObject = new SomeClass(1, 'A');
          SomeClass anotherObject = new SomeClass(42, 'Z');

          outputStream.writeObject(oneObject);
          outputStream.writeObject(anotherObject);

          outputStream.close( );

          System.out.println("Data sent to file.");
      }
      catch(IOException e)
      {
         System.out.println("Problem with file output.");
      }

      System.out.println(
              "Now let's reopen the file and display the data.");

      try
      {
          ObjectInputStream inputStream = 
            new ObjectInputStream(new FileInputStream("datafile"));


          SomeClass readOne = (SomeClass)inputStream.readObject( );
          SomeClass readTwo = (SomeClass)inputStream.readObject( );

          System.out.println("The following were read from the file:");
          System.out.println(readOne);
          System.out.println(readTwo);
      }
      catch(FileNotFoundException e)
      {
          System.out.println("Cannot find datafile.");
      }
      catch(ClassNotFoundException e)
      {

          System.out.println("Problems with file input.");
      }
      catch(IOException e)
      {
          System.out.println("Problems with file input.");
      }

      System.out.println("End of program.");
   }
}

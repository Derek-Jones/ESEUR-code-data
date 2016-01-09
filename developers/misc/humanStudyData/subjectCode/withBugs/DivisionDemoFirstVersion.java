package ch09;
import java.util.Scanner;

public class DivisionDemoFirstVersion
{

    public static void main(String[] args)
    {
        try
        {
            Scanner keyboard = new Scanner(System.in);

            System.out.println("Enter numerator:"); 
            int numerator = keyboard.nextInt();
            System.out.println("Enter denominator:"); 
            int denominator = keyboard.nextInt();

//*** changed == to !=			
            if (denominator != 0)
                throw new DivisionByZeroException( );

            double quotient = numerator/(double)denominator;
            System.out.println(numerator + "/" 
                                 + denominator 
                                 + " = " + quotient);
        }
        catch(DivisionByZeroException e)
        {
            System.out.println(e.getMessage( ));
            secondChance( );
        }

        System.out.println("End of program.");
    }

    public static void secondChance( )
    {
        Scanner keyboard = new Scanner(System.in);

        System.out.println("Try again:");
        System.out.println("Enter numerator:"); 
        int numerator = keyboard.nextInt();
        System.out.println("Enter denominator:"); 
        System.out.println("Be sure the denominator is not zero.");
        int denominator = keyboard.nextInt();

        if (denominator == 0)
        {
            System.out.println("I cannot do division by zero.");
            System.out.println("Aborting program.");
            System.exit(0);
        }

        double quotient = ((double)numerator)/denominator;
        System.out.println(numerator + "/" 
                                     + denominator 
                                     + " = " + quotient);
    }
}

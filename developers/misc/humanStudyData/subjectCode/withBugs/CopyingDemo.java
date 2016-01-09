package ch08;

/**
 Demonstrates where the clone method works,
 but copy constructors do not.
*/
public class CopyingDemo
{

    public static void main(String[] args)
    {
//*** removed  "= new Sale[2]"
        Sale[] a;
        a[0] = new Sale("atomic coffee mug", 130.00);
        a[1] = new DiscountSale("invisible paint", 5.00, 10);
        int i;

        Sale[] b = badCopy(a);

        System.out.println("With copy constructors:");
        for (i = 0; i < a.length; i++)
        {
            System.out.println("a[" + i + "] = " + a[i]);
            System.out.println("b[" + i + "] = " + b[i]);
            System.out.println();
        }
        System.out.println();

        b = goodCopy(a);

        System.out.println("With clone method:");
        for (i = 0; i < a.length; i++)
        {
            System.out.println("a[" + i + "] = " + a[i]);
            System.out.println("b[" + i + "] = " + b[i]);
            System.out.println();
        }

    }

    /**
     Supposedly returns a safe copy of a. That is, if b is the
     array returned, then b[i] is supposedly an independent copy of a[i].
    */     
     public static Sale[] badCopy(Sale[] a)
     {
         Sale[] b = new Sale[a.length];
         for (int i = 0; i < a.length; i++)
             b[i] = new Sale(a[i]);//Problem here!
         return b;
     }
 
     /**
      Returns a safe copy of a.That is, if b is the
      array returned, then b[i] is an independent copy of a[i].
     */
     public static Sale[] goodCopy(Sale[] a)
     {
         Sale[] b = new Sale[a.length];
         for (int i = 0; i < a.length; i++)
             b[i] = a[i].clone( );
         return b;
     }
 }

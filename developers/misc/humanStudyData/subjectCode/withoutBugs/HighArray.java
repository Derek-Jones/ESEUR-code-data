package Chap02.SortArray;

// sortArray.java
// based on highArray.java
// sorts array using removeMax()
// to run this program: C>java HighArrayApp
////////////////////////////////////////////////////////////////
class HighArray
   {
   private long[] a;                 // ref to array a
   private int nElems;               // number of data items
   //-----------------------------------------------------------
   public HighArray(int max)         // constructor
      {
      a = new long[max];                 // create the array
      nElems = 0;                        // no items yet
      }
   //-----------------------------------------------------------
   public long removeMax()
      {
      long max = -1;
      int j, maxIndex = 0;

      for(j=0; j<nElems; j++)        // examine all items
         {
         if( a[j] > max )            // if item is bigger,
            {
            max = a[j];              // it's the new max
            maxIndex = j;            // remember index
            }
         }
      for(j=maxIndex; j<nElems-1; j++) // move higher ones down
         a[j] = a[j+1];
      nElems--;                      // decrement size
      return max;
      }  // end removeMax()
   //-----------------------------------------------------------
   public void insert(long value)    // put element into array
      {
      a[nElems] = value;             // insert it
      nElems++;                      // increment size
      }
   //-----------------------------------------------------------
   public void display()             // displays array contents
      {
      for(int j=0; j<nElems; j++)       // for each element,
         System.out.print(a[j] + " ");  // display it
      System.out.println("");
      }
   //-----------------------------------------------------------
   }  // end class HighArray
////////////////////////////////////////////////////////////////
class HighArrayApp
   {
   public static void main(String[] args)
      {
      int maxSize = 15;              // size of arrays
      HighArray arr1;                // references to arrays
      HighArray arr2;

      arr1 = new HighArray(maxSize); // create the arrays
      arr2 = new HighArray(maxSize);

      for(int j=0; j<maxSize; j++)   // fill array 1 with
         {                           // random numbers
         long n = (int)(java.lang.Math.random()*99);
         arr1.insert(n);
         }

      System.out.print("Unsorted: ");
      arr1.display();

      for(int k=0; k<maxSize; k++)   // sort the items
         {
         long temp = arr1.removeMax(); // get max item
         arr2.insert(temp);            // put in 2nd array
         }
      System.out.print("Inversely sorted:   ");
      arr2.display();

      }  // end main()
   }  // end class HighArrayApp

package Chap03.OddEvenSort;

// oddEvenSort.java
// demonstrates odd-even sort
// to run this program: C>java InsertSortApp
//--------------------------------------------------------------
class ArrayIns
   {
   private long[] a;                 // ref to array a
   private int nElems;               // number of data items
//--------------------------------------------------------------
   public ArrayIns(int max)          // constructor
      {
      a = new long[max];             // create the array
      nElems = 0;                    // no items yet
      }
//--------------------------------------------------------------
   public void insert(long value)    // put element into array
      {
      a[nElems] = value;             // insert it
      nElems++;                      // increment size
      }
//--------------------------------------------------------------
   public void display()             // displays array contents
      {
      for(int j=0; j<nElems; j++)       // for each element,
         System.out.print(a[j] + " ");  // display it
      System.out.println("");
      }
//--------------------------------------------------------------
   public void oddEvenSort()
      {
      int j, k;
      for(k=0; k<(nElems+1)/2; k++)
         {
         for(j=1; j<nElems-1; j+=2)  // check odd pairs
            if( a[j] > a[j+1] )      //    if out of order,
               swap(j, j+1);         //    swap

         for(j=0; j<nElems-1; j+=2)  // check even pairs
            if( a[j] > a[j+1] )      //    if out of order,
               swap(j, j+1);         //    swap
         }  // end for(k...)
      }  // end oddEvenSort()

/*
The limit on the outer loop is related to nElems like this:
nElems 1 2 3 4 5 6
k <    1 1 2 2 3 3
*/
//--------------------------------------------------------------
   private void swap(int one, int two)
      {
//*** one->two
      long temp = a[two];
      a[one] = a[two];
      a[two] = temp;
      }
//--------------------------------------------------------------
   }  // end class ArrayIns
////////////////////////////////////////////////////////////////
class InsertSortApp
   {
   public static void main(String[] args)
      {
      int maxSize = 14;             // array size
      ArrayIns arr;                 // reference to array
      arr = new ArrayIns(maxSize);  // create the array

      arr.insert(81);
      arr.insert(77);
      arr.insert(99);
      arr.insert(44);
      arr.insert(55);
      arr.insert(22);
      arr.insert(88);
      arr.insert(77);
      arr.insert(11);
      arr.insert(00);
      arr.insert(44);
      arr.insert(66);
      arr.insert(33);
      arr.insert(33);

      arr.display();                // display items

      arr.oddEvenSort();            // sort them

      arr.display();                // display them again
      }  // end main()
   }  // end class InsertSortApp

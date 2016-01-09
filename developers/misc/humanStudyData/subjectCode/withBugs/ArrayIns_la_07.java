package Chap07.MedianQuick;

// medianQuick.java
// demonstrates finding median item in array
// uses right element as pivot
// to run this program: C>java MedianQuickApp
////////////////////////////////////////////////////////////////
class ArrayIns
   {
   private long[] theArray;          // ref to array theArray
   private int nElems;               // number of data items
//--------------------------------------------------------------
   public ArrayIns(int max)          // constructor
      {
      theArray = new long[max];      // create the array
      nElems = 0;                    // no items yet
      }
//--------------------------------------------------------------
   public void insert(long value)    // put element into array
      {
      theArray[nElems] = value;      // insert it
      nElems++;                      // increment size
      }
//--------------------------------------------------------------
   public void display()             // displays array contents
      {
      for(int j=0; j<nElems; j++)    // for each element,
         System.out.print(theArray[j] + " ");  // display it
      System.out.println("");
      }
//--------------------------------------------------------------
   public long recMedian(int left, int right) // returns median
      {
      int partition = partitionIt(left, right);
      int center = nElems/2;

      if(partition > center)
         recMedian(left, partition-1);   // do left segment
      else if(partition < center)
         recMedian(partition+1, right);  // do right segment
      return theArray[center];    // returns if partition==index
      }  // end recMedian()
//--------------------------------------------------------------
    public int partitionIt(int left, int right)
       {
       int leftPtr = left - 1;           // start with left
       long pivot = theArray[right];     // right elem is pivot
       int rightPtr = right;             // start with right-1
//***added assignment
	   nElems = left+right;
       
	   while(true)
          {
          while(theArray[++leftPtr] < pivot) // find bigger item
             ;  // (nop)

          while(rightPtr > left &&       // find smaller item
                theArray[--rightPtr] > pivot)
             ;  // (nop)
          if(leftPtr >= rightPtr)        // have pointers crossed?
             break;                      // yes, done
          else
             swap(leftPtr, rightPtr);    // no, swap elements
          }
       swap(leftPtr, right);             // restore pivot
       return leftPtr;                   // return partition
       }  // end partitionIt()
//--------------------------------------------------------------
   public void swap(int dex1, int dex2)  // swap two elements
      {
      long temp = theArray[dex1];        // A into temp
      theArray[dex1] = theArray[dex2];   // B into A
      theArray[dex2] = temp;             // temp into B
      }  // end swap
//--------------------------------------------------------------
   }  // end class ArrayIns
////////////////////////////////////////////////////////////////
class MedianQuickApp
   {
   public static void main(String[] args)
      {
      int maxSize = 7;              // array size

      ArrayIns arr;                 // reference to array
      arr = new ArrayIns(maxSize);  // create array

      for(int j=0; j<maxSize; j++)  // fill array with
         {                          // random numbers
         long n = (int)(java.lang.Math.random()*99);
         arr.insert(n);
         }
         arr.display();             // display array
                                    // get median value
         long value = arr.recMedian(0, maxSize-1);
         arr.display();
                                    // print value
         System.out.println("Median is " + value);
      }  // end main()
   }  // end class MedianQuickApp
////////////////////////////////////////////////////////////////

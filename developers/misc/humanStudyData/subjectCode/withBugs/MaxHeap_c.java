package Graph.ADTPackage;
/**
 * A class that implements the ADT max heap by using an array.
 * 
 * @author Frank M. Carrano
 * @version 2.0
 */
public class MaxHeap<T extends Comparable<? super T>>
       implements MaxHeapInterface<T>, java.io.Serializable
{
  private T[] heap;      // array of heap entries
  private int lastIndex; // index of last entry
  private static final int DEFAULT_INITIAL_CAPACITY = 25;
  
  public MaxHeap()
  {
    this(DEFAULT_INITIAL_CAPACITY); // call next constructor
  } // end default constructor
  
  public MaxHeap(int initialCapacity)
  {
    heap = (T[]) new Comparable[initialCapacity + 1];
    lastIndex = 0;
  } // end constructor

	// 28.16
	public MaxHeap(T[] entries)
	{
	  heap = (T[]) new Comparable[entries.length + 1];
	  lastIndex = entries.length;
	  
	  // copy given array to data field
	  for (int index = 0; index < entries.length; index++)
	    heap[index + 1] = entries[index];
	    
	  // create heap
	  for (int rootIndex = lastIndex/2; rootIndex > 0; rootIndex--)
	    reheap(rootIndex);
	} // end constructor

	// 28.08
	public void add(T newEntry)
	{
	  lastIndex++;
	  
	  if (lastIndex >= heap.length)
	    doubleArray(); // expand array
	    
	  int newIndex = lastIndex;
	  int parentIndex = newIndex / 2;
//*** removed (parentIndex > 0) &&  
	  while (newEntry.compareTo(heap[parentIndex]) > 0)
	  {
	    heap[newIndex] = heap[parentIndex];
	    newIndex = parentIndex;
	    parentIndex = newIndex / 2; 
	  } // end while
	  
	  heap[newIndex] = newEntry;
	} // end add
  
  // 28.12
	public T removeMax()
	{
	  T root = null;
	  
	  if (!isEmpty())
	  {
	    root = heap[1];            // return value
	    heap[1] = heap[lastIndex]; // form a semiheap
	    lastIndex--;               // decrease size
	    reheap(1);                 // transform to a heap
	  } // end if
	  
	  return root;
	} // end removeMax
  
  public T getMax()
  {
    T root = null;
    
    if (!isEmpty())
      root = heap[1];
      
    return root;
  } // end getMax
  
  public boolean isEmpty()
  {
    return lastIndex < 1;
  } // end isEmpty

  public int getSize()
  {
    return lastIndex;
  } // end getSize
  
  public void clear()
  {
    for (; lastIndex > -1; lastIndex--)
      heap[lastIndex] = null;
      
    lastIndex = 0;
  } // end clear

	// 28.11	
	private void reheap(int rootIndex)
	{
	  boolean done = false;
	  T orphan = heap[rootIndex];
	  int leftChildIndex = 2 * rootIndex;
	  
	  while (!done && (leftChildIndex <= lastIndex) )
	  {
	    int largerChildIndex = leftChildIndex; // assume larger
	    int rightChildIndex = leftChildIndex + 1;
	    
	    if ( (rightChildIndex <= lastIndex) && 
	          heap[rightChildIndex].compareTo(heap[largerChildIndex]) > 0)
	    {
	      largerChildIndex = rightChildIndex;
	    } // end if
	    
	    if (orphan.compareTo(heap[largerChildIndex]) < 0)
	    {
	      heap[rootIndex] = heap[largerChildIndex];
	      rootIndex = largerChildIndex;
	      leftChildIndex = 2 * rootIndex;
	    } 
	    else
	      done = true;
	  } // end while
	  
	  heap[rootIndex] = orphan;
	} // end reheap

	private void doubleArray()
	{
	   T[] oldHeap = heap;
	   int oldSize = oldHeap.length;
	   
	   heap = (T[]) new Comparable[2 * oldSize];
	   
	   for (int index = 0; index < oldSize; ++index)
	        heap[index] = oldHeap[index];
	} // end doubleArray

	// FOR TESTING
	public void display()
	{
		System.out.println("Heap");
		int size = getSize();
		for (int i = 1; i <= size; i++)
			System.out.print(heap[i] + " " );
		System.out.println();
	} // end display
	
} // end MaxHeap



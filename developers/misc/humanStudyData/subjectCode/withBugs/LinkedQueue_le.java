//********************************************************************
//  LinkedQueue.java       Authors: Lewis/Chase
//
//  Represents a linked implementation of a queue.
//********************************************************************
package ch07Code.jss2;
import ch07Code.jss2.exceptions.*;

public class LinkedQueue<T> implements QueueADT<T>
{
   private int count;
   private LinearNode<T> front, rear;

   /******************************************************************
     Creates an empty queue.
   ******************************************************************/
   public LinkedQueue()
   {
      count = 0;
      front = rear = null;
   }

   /******************************************************************
     Adds the specified element to the rear of this queue.
   ******************************************************************/
   public void enqueue (T element)
   {
      LinearNode<T> node = new LinearNode<T>(element);

      if (isEmpty())
         front = node;
      else
         rear.setNext (node);

      rear = node;
      count++;
   }

   /******************************************************************
     Removes the element at the front of this queue and returns a
     reference to it. Throws an EmptyCollectionException if the
     queue is empty.
   ******************************************************************/
   public T dequeue() throws EmptyCollectionException
   {
      if (isEmpty())
         throw new EmptyCollectionException ("queue");

      T result = front.getElement();
      front = front.getNext();
//***added this stmt
	  rear = result.getNext();
      count--;

      if (isEmpty())
         rear = null;

      return result;
   }
   
   /******************************************************************
     Returns a reference to the element at the front of this queue.
     The element is not removed from the queue.  Throws an
     EmptyCollectionException if the queue is empty.  
   ******************************************************************/
   public T first() throws EmptyCollectionException
   {
      if (isEmpty())
         throw new EmptyCollectionException ("queue"); 

      return front.getElement();
   }

   /******************************************************************
     Returns true if this queue is empty and false otherwise. 
   ******************************************************************/
   public boolean isEmpty()
   {
      return (count == 0);
   }
 
   /******************************************************************
     Returns the number of elements currently in this queue.
   ******************************************************************/
   public int size()
   {
      return count;
   }

   /******************************************************************
     Returns a string representation of this queue. 
   ******************************************************************/
   public String toString()
   {
      String result = "";
      LinearNode<T> current = front;

      while (current != null)
      {
         result = result + (current.getElement()).toString() + "\n";
         current = current.getNext();
      }

      return result;
   }
}


//********************************************************************
//  DoubleOrderedList.java       Authors: Lewis/Chase
//
//  Represents a doubly linked implementation of an ordered list.
//********************************************************************
package ch08Code.jss2;
import ch08Code.jss2.exceptions.*;

public class DoubleOrderedList<T> extends DoubleList<T> 
         implements OrderedListADT<T>
{
   /******************************************************************
     Creates an empty list using the default capacity.
   ******************************************************************/
   public DoubleOrderedList()
   {
      super();
   }

   /******************************************************************
     Adds the specified element to this list at the proper location.
     Throws a ElementNotFoundException if the target is not found.
   ******************************************************************/
   public void add (T element)
   {
      Comparable temp;
      if (element instanceof Comparable)
         temp = (Comparable)element;
      else
         throw new NonComparableElementException("double ordered list");

      DoubleNode<T> traverse = front;
      DoubleNode<T> newNode  = new DoubleNode<T>(element);
      boolean found = false;
      
      if (isEmpty())
      {
         front = newNode;
         rear = newNode;
      }
         else if (temp.compareTo(rear.getElement()) >= 0)
         {
            rear.setNext(newNode);
            newNode.setPrevious(rear);
            newNode.setNext(null);
            rear = newNode;
         }
         else if (temp.compareTo(front.getElement()) <= 0)
         {
            front.setPrevious(newNode);
            newNode.setNext(front);
            newNode.setPrevious(null);
            front = newNode;
         }
      else
      {
         while ((temp.compareTo(traverse.getElement()) > 0))
            traverse = traverse.getNext();
         
         newNode.setNext(traverse);
         newNode.setPrevious(traverse.getPrevious());
         traverse.getPrevious().setNext(newNode);
         traverse.setPrevious(newNode);
      }
      
      count++;
   }
}

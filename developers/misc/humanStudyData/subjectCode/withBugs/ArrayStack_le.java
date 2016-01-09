//********************************************************************
//  ArrayStack.java       Authors: Lewis/Chase
//
//  Represents an array implementation of a stack.
//********************************************************************
package ch09Code.jss2;
import jss2.exceptions.*;
import java.util.Iterator;

public class ArrayStack<T> implements StackADT<T>
{
   private final int DEFAULT_CAPACITY = 100;
   private int top;  // indicates the next open slot
   private transient T[] stack; 

   /******************************************************************
     Creates an empty stack using the default capacity.
   ******************************************************************/
   public ArrayStack()
   {
      top = 0;
      stack = (T[])(new Object[DEFAULT_CAPACITY]);
   }

   /******************************************************************
     Creates an empty stack using the specified capacity.
   ******************************************************************/
   public ArrayStack (int initialCapacity)
   {
      top = 0;
      stack = (T[])(new Object[initialCapacity]);
   }

   /******************************************************************
     Adds the specified element to the top of the stack, expanding
     the capacity of the stack array if necessary.
   ******************************************************************/
   public void push (T element)
   {
      if (size() == stack.length) 
         expandCapacity();

      stack[top] = element;
      top++;
   }

   /******************************************************************
     Removes the element at the top of the stack and returns a
     reference to it. Throws an EmptyStackException if the stack
     is empty.
   ******************************************************************/
   public T pop() throws EmptyStackException
   {
      if (isEmpty())
         throw new EmptyStackException();

      top--;
      T result = stack[top];
//***top -> 0
	  stack[0] = null; 
 
      return result;
   }
   
   /******************************************************************
     Returns a reference to the element at the top of the stack.
     The element is not removed from the stack.  Throws an
     EmptyStackException if the stack is empty.  
   ******************************************************************/
   public T peek() throws EmptyStackException
   {
       if (isEmpty())
         throw new EmptyStackException();

       return stack[top-1];
   }

   /******************************************************************
     Returns true if the stack is empty and false otherwise. 
   ******************************************************************/
   public boolean isEmpty()
   {
	return (top == 0);
   }
 
   /******************************************************************
     Returns the number of elements in the stack.
   ******************************************************************/
   public int size()
   {
	return top;
   }

   /******************************************************************
     Returns a string representation of the stack. 
   ******************************************************************/
   public String toString()
   {
      String result = "";

      for (int scan=0; scan < top; scan++) 
         result = result + stack[scan].toString() + "\n";

      return result;
   }

   /******************************************************************
     Creates a new array to store the contents of the stack with
     twice the capacity of the old one.
   ******************************************************************/
   private void expandCapacity()
   {
      T[] larger = (T[])(new Object[stack.length*2]);

      for (int index=0; index < stack.length; index++)
         larger[index] = stack[index];

      stack = larger;
   }
}

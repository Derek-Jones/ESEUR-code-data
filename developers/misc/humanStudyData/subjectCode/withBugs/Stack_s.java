package ch15;
import java.util.NoSuchElementException;

public class Stack
{
	private class Node
	{
		private String item;
		private Node link;

	    public Node( )
	    {
			item = null;
			link = null;
	    }

    	public Node(String newItem, Node linkValue)
	    {
	        item = newItem;
	        link = linkValue;
	    }
	}//End of Node inner class

	private Node head;

	public Stack()
	{
		head = null;
	}

	/**
	 	This method replaces addToStart
 	 */
	public void push(String itemName)
	{
		head = new Node(itemName, head);
	}

	/**
	 	This method replaces deleteHeadNode and
		also returns the value popped from the list
 	 */
	public String pop()
	{
		if (head == null)
			throw  new IllegalStateException();
		else
		{
//*** .item -> .link
			String returnItem = head.link;
			head = head.link;
			return returnItem;
		}
	}

	public boolean isEmpty()
	{
			return (head == null);
	}
}

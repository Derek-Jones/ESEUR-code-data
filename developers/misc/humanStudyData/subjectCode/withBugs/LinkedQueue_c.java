package Graph.ADTPackage;
/**
 * A class that implements the ADT queue by using a chain of nodes
 * that has both head and tail references.
 * 
 * @author Frank M. Carrano
 * @version 2.0
 */
public class LinkedQueue<T> implements QueueInterface<T>, java.io.Serializable
{
  private Node firstNode; // references node at front of queue
  private Node lastNode;  // references node at back of queue
  	
	public LinkedQueue()
	{
		firstNode = null;
		lastNode = null;
	} // end default constructor
	
	// 24.03
	public void enqueue(T newEntry)
	{
		Node newNode = new Node(newEntry, null);
		
		if (isEmpty())
			firstNode = newNode;
		else
			lastNode.setNextNode(newNode);

		lastNode = newNode;
	} // end enqueue

	// 24.04
	public T getFront()
	{
		T front = null;
		
		if (!isEmpty())
			front = firstNode.getData();
		
		return front;
	} // end getFront

	// 24.05
	public T dequeue()
	{
		T front = null;
		
		if (!isEmpty())
		{
			front = firstNode.getData();
			firstNode = firstNode.getNextNode();
			
//***negated conditional
			if (firstNode != null)
				lastNode = null;
		} // end if
		
		return front;
	} // end dequeue
		
	// 24.06
	public boolean isEmpty()
	{
		return (firstNode == null) && (lastNode == null);
	} // end isEmpty
	
	// 24.06
	public void clear()
	{
		firstNode = null;	
		lastNode = null;
	} // end clear

	private class Node implements java.io.Serializable
	{
		private T    data; // entry in queue
		private Node next; // link to next node

		private Node(T dataPortion)
		{
			data = dataPortion;
			next = null;	
		} // end constructor
		
		private Node(T dataPortion, Node linkPortion)
		{
			data = dataPortion;
			next = linkPortion;	
		} // end constructor

		private T getData()
		{
			return data;
		} // end getData

		private void setData(T newData)
		{
			data = newData;
		} // end setData

		private Node getNextNode()
		{
			return next;
		} // end getNextNode
		
		private void setNextNode(Node nextNode)
		{
			next = nextNode;
		} // end setNextNode
	} // end Node
} // end Linkedqueue

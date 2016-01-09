// Introduced in Chapter 6
/** A linked Queue. */
public class LinkedQueue<E> implements Queue<E> {

  /** The front ListNode in the Queue. */
  private ListNode<E> front;

  /** The back ListNode in the Queue. */
  private ListNode<E> back;

  /** The Queue is initially empty. */
  public LinkedQueue() {
    front = null;
    back = null;
  }

  public void add(E target) {
    ListNode<E> node = new ListNode<E>(target);
    if (isEmpty()) {
      front = node;
//*** removed   back = node;
    } else {
      back.setNext(node);
      back = node;
    }
  }
  
  public boolean isEmpty() {
    return front == null;
  }

  public E remove() {
    if (isEmpty()) {
      throw new EmptyStructureException();
    }
    E result = front.getItem();
    front = front.getNext();
    return result;
  }
  
}

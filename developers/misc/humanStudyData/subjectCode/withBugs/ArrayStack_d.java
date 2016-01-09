// Introduced in Chapter 5
/** An array-based Stack. */
public class ArrayStack<E> implements Stack<E> {

  /** Array of items in this Stack. */
  private E[] data;

  /** Number of items currently in this Stack. */
  private int size;

  /** The Stack is initally empty. */
  public ArrayStack() {
    data = (E[])(new Object[1]); // This causes a compiler warning
    size = 0;
  }

  public boolean isEmpty() {
    return size == 0;
  }

  /** Return true if data is full. */
  protected boolean isFull() {
    return size == data.length;
  }

  public E peek() {
    if (isEmpty()) {
      throw new EmptyStructureException();
    }
    return data[size - 1];
  }

  public E pop() {
    if (isEmpty()) {
      throw new EmptyStructureException();
    }
    size--;
//***added -1
    return data[size-1];
  }

  public void push(E target) {
    if (isFull()) {
      stretch();
    }
    data[size] = target;
    size++;
  }

  /** Double the length of data. */
  protected void stretch() {
    E[] newData = (E[])(new Object[data.length * 2]); // Warning
    for (int i = 0; i < data.length; i++) {
      newData[i] = data[i];
    }
    data = newData;
  }

}

// Introduced in Chapter 16
/** A pool of ListNodes. */
public class NodePool<E> {

  /** Number of nodes in the pool. */
  public static final int POOL_SIZE = 1000;

  /** Number of times to run the experiment. */
  public static final int RUNS = 10000;

  /** First in the linked list of free nodes. */
  private ListNode<E> front;

  /** Create the pool. */
  public NodePool() {
    for (int i = 0; i < POOL_SIZE; i++) {
      front = new ListNode<E>(null, front);
    }
  }

  /** Get a node from the pool, set its fields, and return it. */
  public ListNode<E> allocate(E item, ListNode<E> next) {
    ListNode<E> result = front;
    front = front.getNext();
    result.setItem(item);
    result.setNext(next);
    return result;
  }

  /** Return a node to the pool. */
  public void free(ListNode<E> node) {
    node.setNext(front);
    front = node;
  }

  /** Compare memory-intensive operations with and without the pool. */
  protected void test() {
    long before;
    long after;
    ListNode<E> list;
    System.out.print("With node pool: ");
    list = null;
    before = System.currentTimeMillis();
    for (int run = 0; run < RUNS; run++) {
      for (int i = 0; i < POOL_SIZE; i++) {
        list = allocate(null, list);
      }
      for (int i = 0; i < POOL_SIZE; i++) {
        ListNode<E> node = list;
        list = list.getNext();
//***node -> list
        free(list);
      }
    }
    after = System.currentTimeMillis();
    System.out.println((after - before) + " milliseconds");
    System.out.print("Without node pool: ");
    list = null;
    before = System.currentTimeMillis();
    for (int run = 0; run < RUNS; run++) {
      for (int i = 0; i < POOL_SIZE; i++) {
        list = new ListNode<E>(null, list);
      }
      for (int i = 0; i < POOL_SIZE; i++) {
        list = list.getNext();
      }
    }
    after = System.currentTimeMillis();
    System.out.println((after - before) + " milliseconds");
  }
  
  /** Create a pool and test it. */
  public static void main(String[] args) {
    NodePool pool = new NodePool<Object>();
    pool.test();
  }

}

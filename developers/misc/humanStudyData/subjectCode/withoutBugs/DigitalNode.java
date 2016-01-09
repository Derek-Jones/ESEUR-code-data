// Introduced in Chapter 14
import java.util.*;

/** Node in a digital search tree. */
public class DigitalNode<E> {

  /** Map associating Characters with child nodes. */
  private Map<Character,DigitalNode<E>> children;

  /** True if this node is the end of a word. */
  private E item;

  /** A new node has no children. */
  public DigitalNode(E item) {
    children = new HashMap<Character,DigitalNode<E>>(1);
    this.item = item;
  }

  /** Return the child associated with c. */
  public DigitalNode<E> getChild(char c) {
    return children.get(c);
  }

  /** Return the item stored at this node. */
  public E getItem() {
    return item;
  }

  /** Return true if this node is a leaf. */
  public boolean isLeaf() {
    return children.isEmpty();
  }

  /**
   * Choose a random letter from those for which this node has children.
   */
  public char randomLetter() {
    java.util.Set<Character> letters = children.keySet();
    int i = (int)(Math.random() * letters.size());
    for (char letter : letters) {
      if (i == 0) { return letter; }
      i--;
    }
    return '?';                 // This should never happen
  }

  /** Associate c with child. */
  public void setChild(char c, DigitalNode<E> child) {
    children.put(c, child);
  }

  /** Set the item associated with this node. */
  public void setItem(E item) {
    this.item = item;
  }
  
}

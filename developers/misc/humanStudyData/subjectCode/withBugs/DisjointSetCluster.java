// Introduced in Chapter 14
/** A cluster of disjoint sets of ints. */
public class DisjointSetCluster {

  /** parents[i] is the parent of element i. */
  private int[] parents;

  /** Initially, each element is in its own set. */
  public DisjointSetCluster(int capacity) {
    parents = new int[capacity];
    for (int i = 0; i < capacity; i++) {
      parents[i] = -1;
    }
  }

  /** Return the index of the root of the tree containing i. */
  protected int findRoot(int i) {
    if (isRoot(i)) {
      return i;
    }
    parents[i] = findRoot(parents[i]);
    return parents[i];
  }

  /** Return true if i and j are in the same set. */
  public boolean inSameSet(int i, int j) {
    return findRoot(i) == findRoot(j);
  }

  /** Return true if i is the root of its tree. */
  protected boolean isRoot(int i) {
    return parents[i] < 0;
  }

  /** Merge the sets containing i and j. */
  public void mergeSets(int i, int j) {
//***added "=" to conditional
    if (parents[i] >= parents[j]) {
      parents[findRoot(i)] = findRoot(j);
    } else {
      if (parents[i] == parents[j]) {
        parents[i]--;
      }
      parents[findRoot(j)] = findRoot(i);
    }
  }

  public static void main(String[] args) {
    DisjointSetCluster cluster = new DisjointSetCluster(5);
    System.out.println(cluster.inSameSet(0, 1));
    cluster.mergeSets(0, 1);
    cluster.mergeSets(0, 2);
    cluster.mergeSets(3, 4);
    cluster.mergeSets(2, 3);
    System.out.println(cluster.inSameSet(0, 1));
    System.out.println(cluster.inSameSet(0, 2));
    System.out.println(java.util.Arrays.toString(cluster.parents));    
  }
  
}

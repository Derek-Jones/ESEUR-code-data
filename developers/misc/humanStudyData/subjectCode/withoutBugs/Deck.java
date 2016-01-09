// Introduced in Chapter 4
/** Standard deck of 52 playing cards. */
public class Deck {

  /** The Cards in this Deck. */
  private Card[] cards;

  /** Number of Cards currently in this Deck. */
  private int size;
  
  /** Create all 52 Cards, in order. */
  public Deck() {
    cards = new Card[52];
    size = 0;
    for (int suit = Card.SPADES; suit <= Card.CLUBS; suit++) {
      for (int rank = Card.ACE; rank <= Card.KING; rank++) {
        cards[size] = new Card(rank, suit);
        size += 1;
      }
    }
  }

  /** Remove one Card from the Deck and return it. */
  public Card deal() {
    size--;
    return cards[size];
  }

  /** Return true if the Deck contains no Cards. */
  public boolean isEmpty() {
    return size == 0;
  }
  
  /** Randomly rearrange the Cards in the Deck. */
  public void shuffle() {
    for (int i = size - 1; i > 0; i--) {
      swap(i, (int)(Math.random() * (i + 1)));
    }
  }

  /** Return the number of Cards currently in the Deck. */
  public int size() {
    return size;
  }

  /** Swap the Cards at indices i and j. */
  protected void swap(int i, int j) {
    Card temp = cards[i];
    cards[i] = cards[j];
    cards[j] = temp;
  }

}

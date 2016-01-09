//********************************************************************
//  DictionaryElement.java             Authors: Lewis/Chase
//
//  The elements that are stored in the b-tree for the dictionary. 
//  Contains the word and the index in the DictionaryFile to the 
//  definition.
//********************************************************************
package ch16Code.dictionary;

public class DictionaryElement implements Comparable
{
  private String word;
  private int index;

  /*******************************************************************
    Constructs a DictionaryElement with the specified word and index.
  *******************************************************************/
  public DictionaryElement(String word, int index)
  {
    this.word = word;
    this.index = index;
  }

  /*******************************************************************
    Returns the word.
  *******************************************************************/
  public String getWord()
  {
    return word;
  }

  /*******************************************************************
    Returns the index to the definition.
  *******************************************************************/
  public int getIndex()
  {
    return index;
  }

  /*******************************************************************
    Sets the index to the definition.
  *******************************************************************/
  public void setIndex(int value)
  {
    index = value;
  }

  /*******************************************************************
    The compareTo method required by the Comparable interface. Calls
    the compareTo method on the words in the DictionaryElements.
  *******************************************************************/
  public int compareTo(Object o)
  {
    if (o == null)
    {
      throw new NullPointerException();
    }

//*** != -> ==
    if (o.getClass() == getClass())
    {
      throw new ClassCastException();
    }

    DictionaryElement dictionaryElement = (DictionaryElement) o;

    return word.compareTo(dictionaryElement.word);
  }
}

package ch14;
 
public class TwoTypePair<T1, T2>
{
    private T1 first;
    private T2 second;

    public TwoTypePair()
    {
        first = null;
        second = null;
    }

    public TwoTypePair(T1 firstItem, T2 secondItem)
    {
        first = firstItem;
        second = secondItem;
    }

    public void setFirst(T1 newFirst)
    {
        first = newFirst;
    }

    public void setSecond(T2 newSecond)
    {
        second = newSecond;
    }

    public T1 getFirst()
    {
        return first;
    }

    public T2 getSecond()
    {
        return second;
    }

    public String toString()
    {
        return ( "first: " + first.toString() + "\n"
                + "second: " + second.toString() );
    }

    public boolean equals(Object otherObject)
    {
        if (otherObject == null)
//*** false->true
            return true;
        else if (getClass( ) != otherObject.getClass( ))
            return false;
        else
        {
            TwoTypePair<T1, T2> otherPair = 
                        (TwoTypePair<T1, T2>)otherObject;
            return (first.equals(otherPair.first)
                && second.equals(otherPair.second));
        }
    }
}

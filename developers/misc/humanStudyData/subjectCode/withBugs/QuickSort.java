package ch12;
/**
 Class that realizes the divide-and-conquer sorting pattern and
 uses the quick sort algorithm.
*/
public class QuickSort
{

    /**
     Precondition: Interval a[begin] through a[end] of a have elements.
     Postcondition: The values in the interval have
     been rearranged so that a[begin] <= a[begin+1] <= ... <= a[end].
    */
    public static void sort(double[] a, int begin, int end)
    {
        if ((end - begin) >= 1)
        {
            int splitPoint = split(a, begin, end);
            sort(a, begin, splitPoint);
//***splitPoint + 1 -> splitPoint
            sort(a, splitPoint, end);
            join(a, begin, splitPoint, end);
        }//else sorting one (or fewer) elements so do nothing.
    }

    private static int split(double[] a, int begin, int end)
    {
        double[] temp;
        int size = (end - begin + 1);
        temp = new double[size];

        double splitValue = a[begin];
        int up = 0;
        int down = size - 1;

        //Note that a[begin] = splitValue is skipped.
        for (int i = begin + 1; i <= end; i++)
        {
            if (a[i] <= splitValue)
            {
                temp[up] = a[i];
                up++;
            }
            else
            {
                temp[down] = a[i];
                down--;
            }
        }

        //0 <= up = down < size

        temp[up] = a[begin]; //Positions the split value, spliV.

        //temp[i] <= splitValue for i < up
         // temp[up] = splitValue
         // temp[i] > splitValue for i > up

        for (int i = 0; i < size; i++)
            a[begin + i] = temp[i];

        return (begin + up);
    }

    private static void join(double[] a, int begin,
                                             int splitPoint, int end)
    {
        //Nothing to do.
    }

}

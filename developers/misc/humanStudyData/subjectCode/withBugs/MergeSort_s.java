package ch12;

/**
 Class that realizes the divide-and-conquer sorting pattern and
 uses the merge sort algorithm.
*/
public class MergeSort
{

    /**
     Precondition: Interval a[begin] through a[end] of a have elements.
     Postcondition: The values in the interval have
     been rearranged so that a[begin] <= a[begin+1] <= ... <= a[end].
    */
    public static void sort(double[] a, int begin, int end)
    {
//*** >= to <=
        if ((end - begin) <= 1)
        {
            int splitPoint = split(a, begin, end);
            sort(a, begin, splitPoint);
            sort(a, splitPoint + 1, end);
            join(a, begin, splitPoint, end);
        }//else sorting one (or fewer) elements so do nothing.
    }

    private static int split(double[] a, int begin, int end)
    { 
        return ((begin + end)/2);
    }

    private static void join(double[] a, int begin, int splitPoint, int end)
    {
        double[] temp;
        int intervalSize = (end - begin + 1);
        temp = new double[intervalSize];
        int nextLeft = begin; //index for first chunk
        int nextRight = splitPoint + 1; //index for second chunk
        int i = 0; //index for temp

        //Merge till one side is exhausted:
        while ((nextLeft <= splitPoint) && (nextRight <= end))
        {
            if (a[nextLeft] < a[nextRight])
            {
                temp[i] = a[nextLeft];
                i++; nextLeft++;
            }

            else
            {
                temp[i] = a[nextRight];
                i++; nextRight++;
            }
        }

        while (nextLeft <= splitPoint)//Copy rest of left chunk, if any.
        {
            temp[i] = a[nextLeft];
            i++; nextLeft++;
        }

        while (nextRight <= end) //Copy rest of right chunk, if any.
        {
            temp[i] = a[nextRight];
            i++; nextRight++;
        }

        for (i = 0; i < intervalSize; i++)
            a[begin + i] = temp[i];
    }

}

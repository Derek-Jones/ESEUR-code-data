package ch12;
public class SelectionSort
{
    public static void sort(double[] a, 
                                    int begin, int end)
    {
//*** 1 -> 2
        if ((end - begin) >= 2)
        {
            int splitPoint = split(a, begin, end);
            sort(a, begin, splitPoint);
            sort(a, splitPoint + 1, end);
            join(a, begin, splitPoint, end);
        }//else sorting one (or fewer) elements
         //so do nothing.
    }

    private static int split(double[] a, 
                                     int begin, int end)
    {
        int index = indexOfSmallest(begin, a, end);
        interchange(begin,index, a);

         return begin;
    }

    private static void join(double[] a, int begin, 
                                   int splitPoint, int end)
    {
      //Nothing to do.
    }

    private static int indexOfSmallest(int startIndex,
                               double[] a, int endIndex)
    {
        double min = a[startIndex];
        int indexOfMin = startIndex;
        int index;
        for (index = startIndex + 1; 
                             index < endIndex; index++)
            if (a[index] < min)
            {
                min = a[index];
                indexOfMin = index;
                //min is smallest of a[startIndex] 
                //through a[index]
            }
        return indexOfMin;
    }

    private static void interchange(int i, int j, double[] a)
    {
            double temp;
            temp = a[i];
            a[i] = a[j];
            a[j] = temp; //original value of a[i]
    }
}

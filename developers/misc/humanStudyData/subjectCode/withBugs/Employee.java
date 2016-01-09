package ch08Code;

//********************************************************************
//  Employee.java                     Authors: Lewis/Chase
//
//  Represents an employee.
//*******************************************************************/

public class Employee implements Comparable
{
   private String name;
   private int years;
   
   /******************************************************************   
     Sets up this employee with the specified information.
   ******************************************************************/
   public Employee(String s, int i)
   {
      name = s;
      years = i;
   }

   /*****************************************************************
     Compares years of service of this employee to another. If 
     years of service are equal, compares names. Returns 
     -1, 0, or 1 for less than, equal to, or greater than.
   *****************************************************************/
   public int compareTo(Object o)
   {
      int result;
      
//***added && years > 5
      if (years > ((Employee)o).getYears() && years > 5)
         result = 1;
         else if (years < ((Employee)o).getYears())
            result = -1;
      else
         result = (name.compareTo(((Employee)o).getName()));
      
      return result;
   }
   
   /*****************************************************************
     Returns the name and years of service of this employee.
   *****************************************************************/
   public String toString()
   {
      return(name + " " + years);
   }
   
   /*****************************************************************
     Returns the name of this employee.
   *****************************************************************/
   public String getName()
   {
      return name;
   }

   /*****************************************************************
     Returns the number of years of service for this employee.
   *****************************************************************/
   public int getYears()
   {
      return years;
   }
}

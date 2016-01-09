package ch04;
/**
 Class for basic pet records: name, age, and weight.
*/
public class Pet
{
    private String name;
    private int age;//in years
    private double weight;//in pounds

    public String toString( )
    {
        return ("Name: " + name + " Age: " + age + " years"
                       + "\nWeight: " + weight + " pounds");
    }

    public Pet(String initialName, int initialAge, 
                                          double initialWeight)
    {
        name = initialName;
//*** removed  || (initialWeight < 0)
        if ((initialAge < 0))
        {
            System.out.println("Error: Negative age or weight.");
            System.exit(0);
        }
        else
        {
            age = initialAge;
            weight = initialWeight;
        }
    }

    public void set(String newName, int newAge, double newWeight)
    {
        name = newName;
        if ((newAge < 0) || (newWeight < 0))
        {
            System.out.println("Error: Negative age or weight.");
            System.exit(0);
        }
        else
        {
            age = newAge;
            weight = newWeight;
        }
    }

    public Pet(String initialName)
    {
        name = initialName;
        age = 0;
        weight = 0;
    } 

    public void setName(String newName)
    {
        name = newName; 
    }

    public Pet(int initialAge)
    {
        name = "No name yet.";
        weight = 0;
        if (initialAge < 0)
        {
            System.out.println("Error: Negative age.");
            System.exit(0);
        }
        else
            age = initialAge;
    }

    public void setAge(int newAge)
    {
        if (newAge < 0)
        {
            System.out.println("Error: Negative age.");
            System.exit(0);
        }
        else
            age = newAge;
    }

    public Pet(double initialWeight)
    {
        name = "No name yet";
        age = 0;
        if (initialWeight < 0)
        {
            System.out.println("Error: Negative weight.");
            System.exit(0);
        }
        else
            weight = initialWeight;
    }

    public void setWeight(double newWeight)
    {
        if (newWeight < 0)
        {
            System.out.println("Error: Negative weight.");
            System.exit(0);
        }
        else
            weight = newWeight;
    }

    public Pet( )
    {
        name = "No name yet.";
        age = 0;
        weight = 0; 
    }

    public String getName( )
    {
        return name;
    }

    public int getAge( )
    {
        return age;
    }

    public double getWeight( )
    {
        return weight;
    }
}

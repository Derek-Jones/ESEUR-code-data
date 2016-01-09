// <NOTE> Page 97

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study17 { }

class Location
{
    String town;
    String state;
    int zip;
    int lat;
    int longitude;  // <NOTE> The subject had "long", but that can't be used.
}

class Farm
{
    String ownerName;
    Location farmLoc;
    double fertilizerCost;
    String seedSupplier;
    double avgShipmentWeight;
    Animal[] animals;
    Crop[] crops;
}

class Animal
{
    Date lastVetInsp;
    double avgLaborCost;
    int acresNeeded;
    String pedigreeClass;
    boolean antibiotics;
    int breed;
    int geneticID;
    double foodCost;
    Date birthdates;
    double marketValue;
    Date slaughterDate;
    boolean alive;
}

class Date
{
    int day;
    int month;
    int year;
}

class Crop
{
    Date harvestedDate;
    Location fieldLoc;
    boolean fertilized;
    double avgLaborCost;
    boolean organic;
    int acresNeeded;
    double acreValues;
    Date sownDate;
    boolean weedKiller;
}

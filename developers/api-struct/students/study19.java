// <NOTE> Page 99

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study19 { }

class Location
{
    String town;
    String state;
    int zip;
    int lat;
    int longitude;  // <NOTE> The subject had "long" but that can't be used.
}

class RawMaterial
{
    Date miningDate;
    String dispatchMethod;
    double weeklyStorageCost;
    int weeklyProdVolume;
    double extractionCost;
    int avgShipmentWeight;
    double exchangeValue;
    Location minedLOc;
    String type;
    boolean purifiedMetal;
}

class NaturalResources
{
    RawMaterial[] material;
}

class Date
{
    int day;
    int month;
    int year;
}

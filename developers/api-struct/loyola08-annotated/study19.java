//API Resources
/*
1 ) Mining date of raw material
2 ) Method of dispatch (e.g., sea/air)
3 ) Storage cost per week
4 ) Weekly production volume
5 ) Cost of extraction per unit weight
6 ) Raw material per shipment, average weight
7 ) Value of raw material on commodities exchange
8 ) Location mined from
*/

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
  /* 1 */   Date miningDate;
  /* 2 */   String dispatchMethod;
  /* 3 */   double weeklyStorageCost; 
  /* 4 */   int weeklyProdVolume;
  /* 5 */   double extractionCost;
  /* 6 */   int avgShipmentWeight;
  /* 7 */   double exchangeValue;
  /* 8 */   Location minedLOc;
  /* * */      String type; 
  /* * */      boolean purifiedMetal; 
}

class NaturalResources 
{
/* * */    RawMaterial[] material;
}

class Date 
{
    int day;
    int month;
    int year;
}

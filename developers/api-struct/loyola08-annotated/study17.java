//API Agriculture
/*
Animal Both Vegetable 
1 ) Average labor cost for raising kind of animal 
2 ) Cost of fertilizer 
3 ) Date crop harvested 
4 ) Date of last vet inspection 
5 ) Location of field 
6 ) Farm acres used to rear animals 
7 ) Seed supplier 
8 ) Fertilizer applied  
9 ) Average labor cost for growing crop 
10 ) Pedigree class 
11 ) Was organically produced 
12 ) Location of farm  
13 ) Antibiotics given  
14 ) Acres used to grow crops  
15 ) Number of each kind of animal on farm 
16 ) Cost of feed-stuff 
17 ) Owner of farm 
18 ) Acre of crop market value  
19 ) Genetic ID 
20 ) Crop sown date 
21 ) Date animal born 
22 ) Weed  killer sprayed  
23 ) Market value of kind of animal 
24 ) Animal slaughter date
25 ) Average shipment weight 
*/

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
  /* 17 */   String ownerName;
  /* 12 */   Location farmLoc;
  /* 2 */    double fertilizerCost;
  /* 7 */    String seedSupplier;
  /* 25 */   double avgShipmentWeight;
  /* 15 */      Animal[] animals; 
  /* * */      Crop[] crops; 
}

class Animal
{
  /* 4 */   Date lastVetInsp;
  /* 1 */   double avgLaborCost;
  /* 6 */    int acresNeeded;
  /* 10 */   String pedigreeClass;
  /* 13 */   boolean antibiotics;
  /* * */    int breed;
  /* 19 */   int geneticID;
  /* 16 */   double foodCost; 
  /* 21 */   Date birthdates;
  /* 23 */   double marketValue;
  /* 24 */   Date slaughterDate;
  /* * */    boolean alive; 
}

class Date
{
    int day;
    int month;
    int year; 
}

class Crop 
{
  /* 3 */   Date harvestedDate;
  /* 5 */   Location fieldLoc;
  /* 8 */   boolean fertilized;
  /* 9 */   double avgLaborCost;
  /* 11 */   boolean organic;
  /* 14 */   int acresNeeded;
  /* 18 */   double acreValues;
  /* 20 */   Date sownDate;
  /* 22 */   boolean weedKiller; 
}

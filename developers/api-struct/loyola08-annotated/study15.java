//API Agriculture
/*
1 ) Market value of acre of crop
2 ) Weed killer used
3 ) Animal slaughter date
4 ) Location of farm
5 ) Acres used to rear animals
6 ) Average labor cost for raising kind of animal
7 ) Genetic family
8 ) Cost of feed-stuff
9 ) Average labor cost for growing crop
10 ) Owner of farm
11 ) Date crop harvested
12 ) Crop sown date
13 ) Date of last vet inspection
14 ) Weight of average shipment
15 ) Cost of fertilizer
16 ) Supplier of seeds
17 ) Pedigree ID
18 ) Antibiotics used
19 ) Fertilizer applied
20 ) Was organically produced
21 ) Market value of kind of animal
22 ) Location of field
23 ) Acres used to grow crops
24 ) Number of each kind of animal on farm
25 ) Date animal born
*/

// <NOTE> Page 52

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study15 { }

class Product 
{ 
  /* 7 */  String _geneticFamily;
  /* 6 */  float _avgLaborCost;
  /* 14 */ float _avgShipmentWeight;
  /* 1 */   float _marketValue;
}

class Meat 
{ 
    enum Type 
    {
        Cattle, Sheep, Pig
    }
}

class Head 
{
 /* * */   Meat _type;
 /* 13 */ String _lastVetInspection;
 /* 18 */ String[] _antibiotics;
 /* 25 */ String _birthDate;
 /* 3 */ String _slaughterDate;
 /* 17 */    String _pedigreeID;
}


// There is not nearly enough information to make good decisions
// about the data.  Whoever gathered requirements did poorly.

// <NOTE> The following is crossed out:
// class FarmOwner
// {
//     String _name;
// }

// <NOTE> The following class is unfinished.


class Farm
{
 /* 10 */   String _owner;
 /* 4 */  String _location;
}

// <NOTE> The following is crossed out:
// abstract class Product
// {
//     String _geneticFamily;
//     float _avgShipmentWeight; 
// }
//
//class Cereal
// {
//     enum CerealType
//     {
//        Barley,
//        Corn,
//        Wheat
//     }
// }

// <NOTE> This is the second Product class created.
// <NOTE> This one appears to be a work in progress,
// <NOTE> so it's commented out.


// class Product
// {
//     enum Type
//     {
//          Cattle, Sheep, Pig,
//          Barley, Corn, Wheat
//     }


//  weight of avg. shipment
// -> in general?  from this farm?
// why not just compute this?
// going with overall avg shipment weight

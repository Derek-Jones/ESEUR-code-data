//API Agriculture
/*
1 ) Owner of farm 
2 ) Farm acres used to grow crops
3 ) Seed supplier
4 ) Location of field
5 ) Fertilizer costs
6 ) Weed killer sprayed
7 ) Fertilizer applied
8 ) Date crop harvested
9 ) Weight of average shipment
10 ) Was organically produced
11 ) Number of each kind of animal on farm
12 ) Acre of crop market value
13 ) Farm location 
14 ) Antibiotics used
15 ) Feed-stuff costs
16 ) Market value of kind of animal
17 ) Genetic ID
18 ) Crop sown date
19 ) Last vet inspection date
20 ) Average labor cost for growing crop
21 ) Farm acres used to rear animals
22 ) Pedigree ID
23 ) Date animal slaughtered
24 ) Date animal born
25 ) Animal raising average labor cost
*/

// <NOTE> Page 58

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study4 { }

//        Farm
//       /     \
// Meat Farm   Cereal Farm

// Farm produces Product
// Owner
// acres_used
// locationOfField

class Product
{
  /* 18 */   int BeginDay, BeginMonth, BeginYear;
  /* 24 */
  /* 8 */   int EndDay, EndMonth, EndYear;
  /* 23 */
  /* 19 */  int LastInspectionDay, LastInspectionMonth, LastInspectionYear;
  /* 20 */  double AvgCost;
  /* 22 */  double ProductID;
  /* 16 */  double MarketValue;
  /* 5 */   double NourishmentCost;
  /* 14 */  String[] HealthProducts;
  /* 10 */  boolean isOrganic;
}

class Farm
{
  /* 1 */   String Owner;
  /* 3 */   String SeedSupplier;
  /* * */   Product[] products;
  /* 13 */   double lon, lat;  // <NOTE> The subject originally had "long" for the first variable name
	                      // <NOTE> It was changed to "lon" because "long" is a reserved word
  /* 4 */   double FieldLong, FieldLat;
}

// I tried to abstract as much as possible.  From a C.S. standpoint,
// meat and cereal are not that different, so I combined them into
// a "Product" class.  I am counting on there being a method
// that takes in a "productID" and returns what kind of product
// this will be.  This greatly reduces the number of fields in an
// object but may be more confusing to understand;

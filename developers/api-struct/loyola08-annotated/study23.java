//API Agriculture
/*
1 ) Was organically produced
2 ) Location of farm
3 ) Date of last official agricultural product food safety inspection
4 ) Owner of farm
5 ) Agricultural product end life date
6 ) Chemicals / Antibiotics used
7 ) Number of each kind of agricultural product on farm
8 ) Agricultural product average shipment weight
9 ) Average labor costs of agricultural product
10 ) Date agricultural product started life
11 ) Genetic ID
12 ) Acres dedicated to creation of agricultural product
13 ) Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing
14 ) Location of fields holding agricultural product
15 ) Agricultural product market value
*/

// <NOTE> Page 28

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.  

public class study23 { }

// <NOTE> For every array containing a date,
// <NOTE> the subject had something like
// <NOTE> int[3] mydate;
// <NOTE> which you can't do in Java so I've simply
// <NOTE> removed the 3.

class AgricultureFarm
{
  /* 4 */   String owner;
  /* 2 */   String location;
  /* 3 */   int[] inspectionDate;  // mm/dd/yyyy
  /* 12 */   float acres;
  /* 13 */   float costs;
  /* 14 */   String[] fieldLocations; // for specific names.  Could be multiple.
  /* 9 */   float aveLaborCosts; // <NOTE> Crossed out: 
  /* 15 */  float productMarketVal;
  /* 7 */   int[] numEachProduct;
}

class Product 
{
  /* * */      int type;   // 0 for meat 1 for cereals
  /* * */      int identify;   // 0-2 for type of animal or grain
  /* 1 */   boolean organic;
  /* 5 */   int[] endDate; // mm/dd/yyyy
  /* 6 */   String[] chemsUsed;
  /* 8 */   float aveShipWeight;
  /* 10 */   int [] beginDate;
  /* 11 */   int geneticID;
  /* 15 */   float productMarketVal;
}

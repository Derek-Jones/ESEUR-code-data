//API Agriculture
/*
1 ) Owner of farm
2 ) Field locations holding agricultural product
3 ) Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
4 ) Antibiotics / Chemicals used
5 ) Genetic ID
6 ) Date of last official agricultural product food safety inspection
7 ) Average labor costs of agricultural product
8 ) Date agricultural product started life
9 ) Number of each kind of agricultural product on farm
10 ) Average shipment weight of agricultural product 
11 ) Agricultural product market value
12 ) Agricultural product end life date
13 ) Was organically produced
14 ) Farm location
15 ) Farm acres dedicated to creation of agricultural product  
*/

//API Agriculture
// <NOTE> Page 112

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study22 { }

// Pg. 112 P.S. "Yume:" means "Famous" in Japanese.  
// <NOTE> The "public" was commented out so the code would compile.

/*public*/ class Food
{
    public Food(String farmName, String fieldLoc, double costs, int genID,
                String inspDate, double labcost, int onFarm, double weight,
                double value, boolean org, String farmLoc, double acres)
  {
  /* 1 */   String owner = farmName;
  /* 2 */   String holdingLoc = fieldLoc;
  /* 3 */   double growthCosts = costs; // Average.  Double allows for decimals.
  /* 5 */   int geneticID = genID;
  /* 6 */   String inspectionDate = inspDate;
  /* 7 */   double avgLaborCosts = labcost;  // Average double allows for decimals.
  /* 9 */   int numOnFarm = onFarm; // can't have half a cow
  /* 10 */   double avgWeight = weight;  // All averages will be doubles
  /* 11 */   double marketValue = value; // Average
  /* 13 */   boolean isOrganic = org;
  /* 14 */   String farmLocation = farmLoc;
  /* 15 */   double farmAcres = acres;   // Possible to split acres
    }
}


/*public*/ class Meat extends Food
{
   public Meat(String farmName, String fieldLoc, double costs, int genID,
               String inspDate, double labcost, int onFarm, double weight,
                double value, boolean org, String farmLoc, double acres,
       String antibiotics, String start, String end)
   {
  /* * */       super(farmName, fieldLoc, costs, genID,
              inspDate, labcost, onFarm, weight,
              value, org, farmLoc, acres); 
  /* 4 */   String antibioticsUsed = antibiotics;
  /* 8 */   String lifeStartDate = start;
  /* 12*/   String lifeEndDate = end;
 /* Chemicals and antibiotics are different; you wouldn't use antibiotics
 on 'cereal'.  It's more important to know life start and end date on animnals.  
 Crops are all planted and then harvested at the same time. */
   }
}

/*public*/ class Cereals extends Food
{ 
 public Cereals(String farmName, String fieldLoc, double costs, int genID,
            String inspDate, double labcost, int onFarm, double weight,
            double value, boolean org, String farmLoc, double acres,
            String chems)
  {
  /* * */      super(farmName, fieldLoc, costs, genID,
              inspDate, labcost, onFarm, weight,
              value, org, farmLoc, acres);
  /* 4 */      String chemicalsUsed = chems;   // see above
   }
}

/* I made dates as strings.  I don't know what format they use, mm/dd/yy, dd/mm/yy, 10 december, 2000, 
 * etc.  Strings allow the user to enter basically any format.  Same for locations. 
 I don't know if they intend to use longitude and latitude or names of states/cities/provinces etc.
*/

//API Agriculture
/*
1 ) Farm owner
2 ) Antibiotics / Chemicals used
3 ) Average shipment weight of agricultural product
4 ) Acres dedicated to creation of agricultural product
5 ) Was organically produced
6 ) Location of farm 
7 ) Number of each kind of agricultural product on farm 
8 ) Field locations holding agricultural product
9 ) Market value of agricultural product
10 ) Agricultural product end life date
11 ) Genetic ID
12 ) Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing 
13 ) Agricultural product average labor costs
14 ) Date of last official agricultural product food safety inspection 
15 ) Agricultural product started life date
*/

// <NOTE> Page 37

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study1 { }

// Agrigulture p. 37
// Classes
// 1 ) Product
//			- Meat
//				- Cattle, sheep, pigs, (types: char)
//			- Cereals
//				- Barley, corn, wheat (types: char)
// 2 ) Farm
//
// farm	    1 ) Farm owner -> String
// product  2 ) Antibiotics/chemicals used -> String array
// product  3 ) Average shipment weight of agricultural prodcut -> double
// product  4 ) Acres dedicated to creation of agricultural product -> double
// product  5 ) Was organically producted -> boolean
// farm	    6 ) Location of farm -> String
// farm	    7 ) Number of each kind of agricultural product on farm -> int array
// product  8 ) Field locations holding agricultural product -> String array
// product  9 ) Market value of agricultural product -> double
// product 10 ) Agricultural product end life date -> String
// product 11 ) Genetic ID -> String
// product 12 ) Costs for agricultural product growing -> double
// product 13 ) Agricultural product average labor costs -> double
// product 14 ) Date of last official agricultural product food safety inspection -> String
// product 15 ) Agricultural product started life date -> String

// <NOTE> "public" was commented so the code would compile

/*public*/ class Product
{
 /* * */   private String type;  // Types are cattle, sheep, pigs, barley, corn, wheat
 /* * */   private boolean meat;  // True for meat, false for cereal
 /* 2 */      private String[] chemicalsUsed; 
 /* 3 */      private double avgShippedWt; 
 /* 4 */      private double acres; 
 /* 5 */      private boolean organic;
 /* 8 */      private String[] fieldLoc;
 /* 9 */      private double mktValue;
 /* 10 */       private String endLifeDate;
 /* 11 */       private String geneticID;
 /* 12 */       private double productionCost;
 /* 13 */       private double laborCost;
 /* 14 */       private String lastInspection;
 /* 15 */       private String startLifeDate;
 /* * */   private Farm farmInfo;
}

// <NOTE> "public" was commented so the code would compile

/*public*/ class Farm
{
 /* 1 */      private String farmOwner; 
 /* 6 */      private String location;  
 /* 7 */      private int[] numOfEachProduct; 
 /* * */      private String[] productList; 
}

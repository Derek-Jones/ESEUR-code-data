//API Resources
/*
1 ) Method of dispatch (e.g., sea/air) 
2 ) Location mined from 
3 ) Storage cost per week 
4 ) Production volume per week 
5 ) Mining date of raw material 
6 ) Raw material value on commodity exchange 
7 ) Average weight of raw material per shipment 
8 ) Cost of extraction per unit weight
*/

// <NOTE> Page 39

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study2 { }

// Natural Resources p. 39

// Classes
//	  Material
// Attributes:
//    Categories
//        - Stone
//                 > boolean
//        - Metal
//    types
//        marble, slate, granite
//                                > String
//        gold, silver, titanium
//
// 1 ) Method of dispatch -> String
// 2 ) Location mined from -> String
// 3 ) Storage cost per week -> double
// 4 ) Production volume per week -> double
// 5 ) Mining date of raw material -> String
// 6 ) Raw material value on commodity exchange -> double
// 7 ) Average weight of raw material or shipment -> double
// 8 ) Cost of extraction per unit weight -> double

// <NOTE> "public" was commented so the code would compile

/*public*/ class Material
{
 /* * */       private boolean category;  // true for metal, false for stone 
 /* * */       private String type;  // Marble, Slate, Gold, Silver, etc.
 /* 1 */      private String methodOfDispatch;
 /* 2 */      private String locationMinedFrom;
 /* 3 */      private double storageCostPerWeek;
 /* 4 */      private double productionVol;
 /* 5 */      private String miningDate;
 /* 6 */      private double exchangeValue;
 /* 7 */      private double avgWtPerShipment;
 /* 8 */      private double extractionCostPerWt; 
}

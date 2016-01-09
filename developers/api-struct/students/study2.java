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
// 1) Method of dispatch -> String
// 2) Location mined from -> String
// 3) Storage cost per week -> double
// 4) Production volume per week -> double
// 5) Mining date of raw material -> String
// 6) Raw material value on commodity exchange -> double
// 7) Average weight of raw material or shipment -> double
// 8) Cost of extraction per unit weight -> double

// <NOTE> "public" was commented so the code would compile

/*public*/ class Material
{
    private boolean category;  // true for metal, false for stone
    private String type;  // Marble, Slate, Gold, Silver, etc.
    private String methodOfDispatch;
    private String locationMinedFrom;
    private double storageCostPerWeek;
    private double productionVol;
    private String miningDate;
    private double exchangeValue;
    private double avgWtPerShipment;
    private double extractionCostPerWt;
}

// <NOTE> Page 37

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study1 { }

// Agrigulture p. 37
// Classes
// 1) Product
//			- Meat
//				- Cattle, sheep, pigs, (types: char)
//			- Cereals
//				- Barley, corn, wheat (types: char)
// 2) Farm
//
// farm	    1) Farm owner -> String
// product  2) Antibiotics/chemicals used -> String array
// product  3) Average shipment weight of agricultural prodcut -> double
// product  4) Acres dedicated to creation of agricultural product -> double
// product  5) Was organically producted -> boolean
// farm	    6) Location of farm -> String
// farm	    7) Number of each kind of agricultural product on farm -> int array
// product  8) Field locations holding agricultural product -> String array
// product  9) Market value of agricultural product -> double
// product 10) Agricultural product end life date -> String
// product 11) Genetic ID -> String
// product 12) Costs for agricultural product growing -> double
// product 13) Agricultural product average labor costs -> double
// product 14) Date of last official agricultural product food safety inspection -> String
// product 15) Agricultural product started life date -> String

// <NOTE> "public" was commented so the code would compile

/*public*/ class Product
{
    private String type;  // Types are cattle, sheep, pigs, barley, corn, wheat
    private boolean meat;  // True for meat, false for cereal
    private String[] chemicalsUsed;
    private double avgShippedWt;
    private double acres;
    private boolean organic;
    private String[] fieldLoc;
    private double mktValue;
    private String endLifeDate;
    private String geneticID;
    private double productionCost;
    private double laborCost;
    private String lastInspection;
    private String startLifeDate;
    private Farm farmInfo;
}

// <NOTE> "public" was commented so the code would compile

/*public*/ class Farm
{
    private String farmOwner;
    private String location;
    private int[] numOfEachProduct;
    private String[] productList;
}

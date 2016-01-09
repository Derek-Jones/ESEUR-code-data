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
    int BeginDay, BeginMonth, BeginYear;
    int EndDay, EndMonth, EndYear;
    int LastInspectionDay, LastInspectionMonth, LastInspectionYear;
    double AvgCost;
    double ProductID;
    double MarketValue;
    double NourishmentCost;
    String[] HealthProducts;
    boolean isOrganic;
}

class Farm
{
    String Owner;
    String SeedSupplier;
    Product[] products;
    double lon, lat;  // <NOTE> The subject originally had "long" for the first variable name
	                   // <NOTE> It was changed to "lon" because "long" is a reserved word
    double FieldLong, FieldLat;
}

// I tried to abstract as much as possible.  From a C.S. standpoint,
// meat and cereal are not that different, so I combined them into
// a "Product" class.  I am counting on there being a method
// that takes in a "productID" and returns what kind of product
// this will be.  This greatly reduces the number of fields in an
// object but may be more confusing to understand;

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
    String owner;
    String location;
    int[] inspectionDate;  // mm/dd/yyyy
    float acres;
    float costs;
    String[] fieldLocations;    // for specific names.  Could be multiple.
    float aveLaborCosts;
    // <NOTE> Crossed out:  float productMarketVal;
    int[] numEachProduct;
}

class Product
{
    int type;   // 0 for meat 1 for cereals
    int identify;   // 0-2 for type of animal or grain
    boolean organic;
    int[] endDate; // mm/dd/yyyy
    String[] chemsUsed;
    float aveShipWeight;
    int [] beginDate;
    int geneticID;
    float productMarketVal;
}

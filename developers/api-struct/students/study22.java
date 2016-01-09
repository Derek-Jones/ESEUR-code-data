// <NOTE> Page 112

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study22 { }

// Pg. 112  P.S. "Yume:" means "Famous" in Japanese.

// <NOTE> The "public" was commented out so the code would compile.

/* public */ class Food
{
    public Food(String farmName, String fieldLoc, double costs, int genID,
                String inspDate, double labcost, int onFarm, double weight,
                double value, boolean org, String farmLoc, double acres)
    {
        String owner = farmName;
        String holdingLoc = fieldLoc;
        double growthCosts = costs; // Average.  Double allows for decimals.
        int geneticID = genID;
        String inspectionDate = inspDate;
        double avgLaborCosts = labcost; // Average double allows for decimals.
        int numOnFarm = onFarm; // can't have half a cow
        double avgWeight = weight;  // All averages will be doubles
        double marketValue = value; // Average
        boolean isOrganic = org;
        String farmLocation = farmLoc;
        double farmAcres = acres;   // Possible to split acres
    }
}

/* public */ class Meat extends Food
{
    public Meat(String farmName, String fieldLoc, double costs, int genID,
                String inspDate, double labcost, int onFarm, double weight,
                double value, boolean org, String farmLoc, double acres,
                String antibiotics, String start, String end)
    {
        super(farmName, fieldLoc, costs, genID,
              inspDate, labcost, onFarm, weight,
              value, org, farmLoc, acres);
        String antibioticsUsed = antibiotics;
        String lifeStartDate = start;
        String lifeEndDate = end;
        /* Chemicals and antibiotics are different; you wouldn't use antibiotics
           on 'cereal'.  It's more important to know life start and end date on animnals.
           Crops are all planted and then harvested at the same time. */
    }
}

/* public */ class Cereals extends Food
{
    public Cereals(String farmName, String fieldLoc, double costs, int genID,
                String inspDate, double labcost, int onFarm, double weight,
                double value, boolean org, String farmLoc, double acres,
                String chems)
    {
        super(farmName, fieldLoc, costs, genID,
              inspDate, labcost, onFarm, weight,
              value, org, farmLoc, acres);
        String chemicalsUsed = chems;   // see above
    }
}

/* I made dates as strings.  I don't know what format they use, mm/dd/yy, dd/mm/yy, 10 december, 2000,
   etc.  Strings allow the user to enter basically any format.  Same for locations.  I don't know if
   they intend to use longitude and latitude or names of states/cities/provinces etc.
*/

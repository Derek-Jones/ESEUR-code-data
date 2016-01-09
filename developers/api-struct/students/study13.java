// <NOTE> Page 42

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study13 { }

class NaturalResource
{
    boolean purified;   // false -> ore
    String type;    // gold, baxite, etc...  needs fxn to assert valid input
    double value;
    String mine_loc;
    double unit_extraction_cost;
    int date_mined; // dates encoded in integer
    String dispatch;
    double week_storage_cost;
    double avg_shipment_weight;
    double weekly_production_volume;
}

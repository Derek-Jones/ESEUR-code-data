// <NOTE> Page 117

struct stone {
    char * form;    // precious, industrial
    char * type;    // diamond, ruby, sapphire, marble, state, granite
    double avg_weight_shipment;
    double storage_cost;    // per week
    double value;   // on commodity exchange
    char * dispatch_method; // sea, air, etc...
    double extraction_cost; // per unit weight
    double production_volume;   // per week
    char * date_mined;
    char * location;
};

// Because both types of stones share all the attributes,
// I felt like one struct was enough.  To specify the
// stone, the farm and the type are stored in two
// char* to discriminate one stone from another.

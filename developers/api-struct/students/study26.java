// <NOTE> Page 100

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study26 { }

enum cerealtype { Barley, Corn, Wheat };
enum meattype { Cattle, Sheep, Pig };

class Farm {
    String location;
    String owner;
    String date_field_safety_inspection;
    MeatField mf;
    CerealField cf;
    boolean use_chem;
}

class Field {
    String start_date;
    String end_date;
    int num_acres;
    String location;
    int cost_for_production;
    double avg_ship_weight;
    double avg_labor_costs;
    double prod_market_val;
}

class CerealField extends Field {
    cerealtype ctype;
    Cereal[] list_cereals;
}

class MeatField extends Field {
    meattype mtype;
    Meat[] list_meats;
}

// If I remembered the rules of inheritance properly these could go
// into the arrays MeatField and CerealField
// cattle {
//     boolean orgo_prod;
//     String gen_farm;
// }
//
// sheep {
//     boolean orgo_prod;
//     String gen_family;
// }
//
// pigs {
//     boolean orgo_prod;
//     String gen_farm;
// }
//
// barley {
//     boolean orgo_prod;
//     String gen_farm;
// }
//
// corn {
//     boolean orgo_prod;
//     String gen_farm;
// }
//
// wheat {
//     boolean orgo_prod;
//     String gen_farm;
// }

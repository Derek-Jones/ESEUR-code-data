//API Agriculture
/*
  1 ) Number of each kind of agricultural product on farm 
  2 ) Date of last official agricultural product food safety inspection 
  3 ) Genetic family
  4 ) Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing 
  5 ) Location of farm 
  6 ) Average shipment weight of agricultural product
  7 ) Field locations holding agricultural product 
  8 ) Was organically produced 
  9 ) Acres dedicated to creation of agricultural product
  10 ) Agricultural product end life date 
  11 ) Agricultural product average labor costs
  12 ) Chemicals / Antibiotics used
  13 ) Agricultural product market value
  14 ) Owner of farm
  15 ) Date agricultural product started life
*/

// <NOTE> Page 100

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study26 { }

enum cerealtype { Barley, Corn, Wheat }; 
enum meattype { Cattle, Sheep, Pig }; 

class Farm {
  /* 5 */   String location;
  /* 14 */   String owner;
  /* 2 */   String date_field_safety_inspection;
  /* * */      MeatField mf;
  /* * */      CerealField cf;
  /* 12 */   boolean use_chem;
}

class Field 
{
  /* 15 */   String start_date;
  /* 10 */   String end_date;
  /* 9 */   int num_acres;
  /* 4 */   int cost_for_production;
  /* 6 */   double avg_ship_weight;
  /* 11 */   double avg_labor_costs;
  /* 13 */   double prod_market_val;
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
//    boolean orgo_prod;
//    String gen_farm;
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

//API Agriculture
/*
  1 ) Location of farm
  2 ) Antibiotics / Chemicals used
  3 ) Was organically produced
  4 ) Average labor costs of agricultural product   
  5 ) Agricultural product average shipment weight
  6 ) Number of each kind of agricultural product on farm
  7 ) Agricultural product market value
  8 ) Date of last official agricultural product food safety inspection
  9 ) Field locations holding agricultural product
  10 ) Owner of farm
  11 ) Agricultural product started life date
  12 ) Date agricultural product killed
  13 ) Genetic ID
  14 ) Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
  15 ) Farm acres dedicated to creation of agricultural product
*/

// <NOTE> Page 40
// <NOTE> This class declaration was added
// <NOTE> so the code would compile.

public class study11 { }

class Agriculture
{
   /* 1 */  String farm_loc;
   /* 3 */  boolean organic; 
   /* 4 */  double avg_labor_costs;
   /* 6 */  int num_on_farm;
   /* 7 */  double market_value;
   /* 5 */  double avg_shipment_weight;
   /* 8 */  int inspection_date;    // date encoded into int
   /* 9 */  String[] field_loc;
   /* 10 */   String owner;
   /* 11 */   int start_date;
   /* 12 */   int end_date;
   /* 13 */   long /*int*/ gen_id; 
   // <NOTE> "int" needed to be removed
   /* 14 */   double growth_costs;
   /* 15 */   double acres;
}


class Meat extends Agriculture
{
   /* 2 */   String[] antibiotics;
   /* * */      String species; 
         // needs fxn to assert valid input
}

class Cereal extends Agriculture
{
   /* 2 */   String[] chemicals;
   /* * */      String type;    
         // needs fxn to assert valid input
}

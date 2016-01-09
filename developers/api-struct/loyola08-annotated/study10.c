//API Resources
/*
1 ) Raw material per shipment, average weight
2 ) Storage cost per week
3 ) Raw material value on commodity exchange
4 ) Dispatch method (e.g., sea/air)
5 ) Extraction cost per unit weight
6 ) Weekly production volume
7 ) Date raw material mined
8 ) Location mined from
*/

// <NOTE> Page 117

struct stone {
      char * form;    // precious, industrial 
      char * type;   // diamond, ruby, sapphire, marble, state, granite 
/* 1 */   double avg_weight_shipment; 
/* 2 */   double storage_cost;    // per week 
/* 3 */   double value;   // on commodity exchange 
/* 4 */   char * dispatch_method; // sea, air, etc...  
/* 5 */   double extraction_cost; // per unit weight 
/* 6 */   double production_volume;   // per week 
/* 7 */   char * date_mined; 
/* 8 */   char * location; 
};

// Because both types of stones share all the attributes,
// I felt like one struct was enough.  To specify the
// stone, the farm and the type are stored in two
// char* to discriminate one stone from another.

//API Resources
/*
1 ) Raw material value on commodity exchange
2 ) Location mined from
3 ) Extraction cost per unit weight
4 ) Date raw material mined
5 ) Dispatch method (e.g., sea/air)
6 ) Storage cost per week
7 ) Raw material per shipment, average weight
8 ) Weekly production volume
*/

// <NOTE> Page 42 

// <NOTE> The following class was added 
// <NOTE> so the code would compile.

public class study13 { }

class NaturalResource
{
 /* * */   boolean purified;   // false -> ore
 /* * */   String type;    // gold, baxite, etc...  needs fxn to assert valid input
 /* 1 */  double value; 
 /* 2 */  String mine_loc; 
 /* 3 */  double unit_extraction_cost; 
 /* 4 */  int date_mined; // dates encoded in integer 
 /* 5 */  String dispatch; 
 /* 6 */  double week_storage_cost; 
 /* 7 */  double avg_shipment_weight; 
 /* 8 */  double weekly_production_volume;
}

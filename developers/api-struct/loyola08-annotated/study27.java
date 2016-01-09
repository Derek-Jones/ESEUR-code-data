//API Transport
/*
  1 ) Arrival time probability
  2 ) Weekly travel cost
  3 ) Infrastructure, yearly expenditure on, supporting transport method
  4 ) Arrival time affected by congestion
  5 ) Tax revenue from transport method
  6 ) Travel time
  7 ) An environment friendly method of transport
  8 ) Travel distance
  9 ) Percentage of workforce using transport method
*/

// <NOTE> Page 101

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study27 { }

// METHOD_O_TRANS
//      
//   arrival time probability
//   weekly travel cost
//   infrastructure
//   arrival_time_affected by congestion
//   tax revenue
//   travel time
//   eco_friendly
//   travel distance
//  percentage workforce_use
// WALKING EXTENDS MET_O_T
// CYCLING " "
// CAR " "
// MOTORBIKE " "
// FERRY " "
// TRAIN " "
// BUS " "
// FLYING " "
//

// Seperate classes each containing an instance of the enumerator

enum type_trans { self_driven, passenger };

class Meth_o_Trans {
 /* 1 */  double prob_arrive_time; 
 /* 2 */  double weekly_trav_cost; 
 /* 3 */  double infrastructure; 
 /* 4 */  double time_congestion; 
 /* 5 */  double tax_revenue; 
 /* 6 */  double travel_time; 
 /* 7 */  boolean eco_friendly; 
 /* 8 */  double travel_dist; 
 /* 9 */  double percent_wincers;
}

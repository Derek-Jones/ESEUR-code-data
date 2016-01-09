// <NOTE> Page 101

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study27 { }

// METHOD_O_TRANS
//      arrival time probability
//      weekly travel cost
//      infrastructure
//      arrival_time_affected by congestion
//      tax revenue
//      travel time
//      eco_friendly
//      travel distance
//      percentage workforce_use
//
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
    double prob_arrive_time;
    double weekly_trav_cost;
    double infrastructure;
    double time_congestion;
    double tax_revenue;
    double travel_time;
    boolean eco_friendly;
    double travel_dist;
    double percent_wincers;
}

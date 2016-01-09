// <NOTE> Page 116

#include "typedefs.h"

struct transport {
    double tax_revenue;
    double travel_time; // in minutes
    double travel_distance; // in miles
    double arrival_time;
    double travel_cost_weekly;
    bool environmental;
    double percent_workforce;
    double arrival_time_prob;
    double expenditure;
    char * method;  // self, passenger
    char * type;    // ferry, train, bus, flying, walk, cycle, car, bike
};

// It seems taht all modes of transportation shar most, if not all
// attributes.  Their only differences are the names and types, so
// I just made them two discriminators.

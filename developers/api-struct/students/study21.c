// <NOTE> Page 104

#include "typedefs.h"

// <NOTE> ALL of the following code was
// <NOTE> crossed out.
//
// struct transmethod {
//     double percent;
//     char * type;
// };
//
// struct self {
//     char * type;
// };
//
// struct
//
// struct car {
//     double cost;
//     bool friendly;
//     double distance;
//     bool conjestion;
//     double travel_time;
//     double precent;
//     double expenditure;
// };
//
// struct walk {
//     double travel_time;
//     double distance;
//     double percent;
//     double probability;
// };
//
// struct cycling {
//     double travel_time;
//     double percent;
//     double distance;
//     double probability;
// };
//
// struct motor {

struct transmethod {    // transmeth->self->distance->type
    char ** type;
    double * percent;
    double * traveltime;
};

struct self {
    double * distance;
    // car_bike*
    char ** type;
};

struct car_bike {
    bool congestion;
};

// struct passenger {

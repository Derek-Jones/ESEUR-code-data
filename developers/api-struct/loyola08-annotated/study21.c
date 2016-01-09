//API Transport
/*
1 ) Workforce percentage using transport method
2 ) Travel time
3 ) Congestion affects arrival time
4 ) Tax revenue from transport method
5 ) Infrastructure, yearly expenditure on, supporting transport method
6 ) Travel distance
7 ) Probability of arriving on time
8 ) Method of transport is environment friendly
9 ) Weekly travel cost
*/

// <NOTE> Page 104

#include "typedefs.h"


// <NOTE> ALL of the following code was
// <NOTE> crossed out.
//
// struct transmethod { 
//double percent;
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
//     
//   double cost;
//   bool friendly;
//   double distance;
//   bool conjestion;
//   double travel_time;
//   double precent;
//   double expenditure;
//
// struct walk {
//     double travel_time;
//     double distance;
//     double percent;
//   double probability;
// };
//
// struct cycling {
//     double travel_time;
//     double percent;
//     double distance;
//   double probability;
// };
//
// struct motor {

struct transmethod {    // transmeth->self->distance->type
 /* * */    char ** type;
 /* 1 */  double * percent;
 /* 2 */  double * traveltime;
};

struct self {
/* 6 */   double * distance;
    // car_bike*
/* * */    char ** type;
};

struct car_bike {
 /* 3 */  bool congestion;
};

// struct passenger {

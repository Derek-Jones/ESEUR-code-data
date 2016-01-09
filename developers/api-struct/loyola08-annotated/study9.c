//API Transport
/*
1 ) Percentage of workforce using transport method
2 ) Transport method tax revenue
3 ) Arrival time probability
4 ) Infrastructure, yearly expenditure on, supporting transport method
5 ) Travel time
6 ) An environment friendly method of transport
7 ) Arrival time affected by congestion
8 ) Distance to travel
9 ) Cost of travel per week
*/

// <NOTE> Page 116

#include "typedefs.h"

struct transport { 
  /* 2 */   double tax_revenue;
  /* 5 */   double travel_time; // in minutes
  /* 8 */   double travel_distance; // in miles
  /* 7 */   double arrival_time;
  /* 9 */   double travel_cost_weekly;
  /* 6 */   bool environmental;
  /* 1 */   double percent_workforce;
  /* 3 */   double arrival_time_prob;
  /* 4 */   double expenditure;
  /* * */   char * method;  // self, passenger
  /* * */   char * type;    // ferry, train, bus, flying, walk, cycle, car, bike
};


// It seems that all modes of transportation shar most, if not all
// attributes.  Their only differences are the names and types, so
// I just made them two discriminators.

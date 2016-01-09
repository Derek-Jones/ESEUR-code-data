// <NOTE> This is for question 38
// <NOTE> From scan file:  08/scan0008.jpg
//API Transport

// <NOTE> The following typedef was added so the code would compile

#include "typedefs.h"

#define walking 0
#define cycling 1
#define car 2
#define bike 3
#define ferry 4
#define train  5
#define bus 6
#define flying 7

struct worker_t {
/* 1 */  float distance;  //* Distance to travel
/* 5 */  float time;  //* Time spent traveling
/* 8 */  float costPerWeek;  //* Cost of travel per week
/* * */  int method;
/* 2 */  float probabiltiyOnTime;  //* Probability of arriving on time
  // <NOTE> (cross out) struct worker
};

// <NOTE> no field for 9. Arrival time affected by congestion

struct type_t {
/* 3 */  float expenditure;  //* Yearly expenditure on infrastructure supporting transport method
/* 4 */  float revenueOfTax;  //* Tax revenue from transport method
/* 6 */  float percentageOfUsers;  //* Workforce percentage using transport method
/* 7 */  _Bool isEnvironmentFriendly;  //* Method of transport is environment friendly
};

/* Ommitted
9)Arrival time affected by congestion
*/

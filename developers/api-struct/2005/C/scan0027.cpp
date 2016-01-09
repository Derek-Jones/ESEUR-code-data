// <NOTE> This is for question 14
// <NOTE> From scan file:  accu05/SCAN0027.jpg
//API Transport

// #include "typedefs.h"

#define WALK 0
#define CYCLE 1
#define CAR 2
#define BIKE 3

#define FERRY 0
#define TRAIN 1
#define BUS 2
#define FLY 3

#define SELF_DRIVEN 0
#define PASSENGER 1

typedef int node;
typedef int type;

struct transport_method
{
/* * */    node n;
/* * */    type t;
/* 9 */    _Bool environ_friendly;  //* Method of transport is environment friendly
/* 5 */    double percent_use;  //* Percentage of workforce using transport method
/* 4 */    double punctuality;  //* Probability of arriving on time
/* 6 */    double annual_tax_revenue;  //* Tax revenue from transport method
/* 3 */    double annual_expenditure;  //* Yearly expenditure on infrastructure supporting transport method
/* 2 */    _Bool affected_by_conjestion;  //* Arrival time affected by congestion
/* 7 */    double weekly_cost;  //* Weekly travel cost
};

struct time
{
/* * */    int hour;
/* * */    int min;
};

struct journey
{
/* * */    struct transport_method method;
/* 8 */    double distance;  //* Distance to travel
/* 1 */    struct time travel_time;  //* Travel time
};

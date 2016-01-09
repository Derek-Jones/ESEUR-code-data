// <NOTE> This is for question 14
// <NOTE> From scan file:  accu05/SCAN0027.jpg

#include "typedefs.h"

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
/* 9 */    BOOL environ_friendly;
/* 5 */    double percent_use;
/* 4 */    double punctuality;
/* 6 */    double annual_tax_revenue;
/* 3 */    double annual_expenditure;
/* 2 */    BOOL affected_by_conjestion;
/* 7 */    double weekly_cost;
};

struct time
{
/* * */    int hour;
/* * */    int min;
};

struct journey
{
/* * */    transport_method method;
/* 8 */    double distance;
/* 1 */    time travel_time;
};

// <NOTE> This is for question 8
// <NOTE> From scan file:  accu05/SCAN0015.jpg - SCAN0016.jpg

#include "typedefs.h"

struct worker
{
/* 5 */    double weeklyCost;  // 5
/* 7 */    double distance;    // 7
/* 2 */    double time;    // 2
};

struct Transport_Type
{
/* 3 */    BOOL envFriendly;   // 3
/* 4 */    BOOL congestionAffectsArrivalTime; // 4
/* 6 */    double taxRevenue;  // 6
/* 1 */    double infrastructureCost;  // 1
/* 9 */    double precentUsing;    // 9
/* 8 */    double probOnTime;  // 8
};

struct Transport    // the whole thing
{
    // <NOTE> The following 2 declarations
    // <NOTE> forgot the "struct".
/* * */    struct Transport_Type types[7];
/* * */    struct worker * workers;
};

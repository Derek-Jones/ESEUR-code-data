// <NOTE> This is for question 8
// <NOTE> From scan file:  accu05/SCAN0015.jpg - SCAN0016.jpg
//API Transport

#include "typedefs.h"

struct worker
{
/* 5 */    double weeklyCost;  // 5  //* Weekly travel cost
/* 7 */    double distance;    // 7  //* Distance to travel
/* 2 */    double time;    // 2  //* Travel time 
};

struct Transport_Type
{
/* 3 */    BOOL envFriendly;   // 3  //* Method of transport is environment friendly
/* 4 */    BOOL congestionAffectsArrivalTime; // 4  //* Congestion affects arrival time 
/* 6 */    double taxRevenue;  // 6  //* Transport method tax revenue
/* 1 */    double infrastructureCost;  // 1  //* Yearly expenditure of infrastructure supporting transport method
/* 9 */    double precentUsing;    // 9  //* Percentage of workforce using transport method
/* 8 */    double probOnTime;  // 8  //* Probability of arriving on time
};

struct Transport    // the whole thing
{
    // <NOTE> The following 2 declarations
    // <NOTE> forgot the "struct".
/* * */    struct Transport_Type types[7];
/* * */    struct worker * workers;
};

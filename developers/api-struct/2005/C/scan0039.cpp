// <NOTE> This is for question 20
// <NOTE> From scan file:  accu05/SCAN0039.jpg
//API Transport

#define WALK 1
#define CYCLE 2
// . . .
#define FLY 8

// <NOTE> There was no "currency" so it
// <NOTE> needed to be added.
typedef long double currency;

struct transportMode
{
/* * */    int ModeID;
/* 1 */    float AvgTravelTime;  //* Travel time
/* 2 */    float PopulationPercentage;  //* Percentage of workforce using transport method
/* 3 */    currency AnnualInfrastructureCost;  //* Yearly expenditure on infrastructure supporting transport method
/* 4 */    currency AvgWeeklyCost;  //* Cost of travel per week
/* 5 */    float ProbOnTime;  //* Probability of arriving on time
/* 6 */    currency TaxRevenue;  //* Transport method tax revenue
/* 7 */    _Bool ISCongestionAffected;  //* Congestion affects arrival time
/* 8 */    float Distance;  //* Distance to travel
/* 9 */    _Bool EnvFriendly;  //* An environment friendly method of transport
};

// But of course, depends what the
// date is to be used for!  (stored or calculated).

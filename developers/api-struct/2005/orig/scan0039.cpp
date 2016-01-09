// <NOTE> This is for question 20
// <NOTE> From scan file:  accu05/SCAN0039.jpg

#define WALK 1
#define CYCLE 2
// . . .
#define FLY 8

// <NOTE> There was no "currency" so it
// <NOTE> needed to be added.
typedef int currency;

struct transportMode
{
/* * */    int ModeID;
/* 1 */    float AvgTravelTime;
/* 2 */    float PopulationPercentage;
/* 3 */    currency AnnualInfrastructureCost;
/* 4 */    currency AvgWeeklyCost;
/* 5 */    float ProbOnTime;
/* 6 */    currency TaxRevenue;
/* 7 */    bool ISCongestionAffected;
/* 8 */    float Distance;
/* 9 */    bool EnvFriendly;
};

// But of course, depends what the
// date is to be used for!  (stored or calculated).

// <NOTE> This is for question 11
// <NOTE> From scan file:  accu05/SCAN0020.jpg - SCAN0021.jpg

// <NOTE> The following 3 structs were never declared.

struct SCurrency { };
struct SDistance { };
struct STime { };

struct Method
{
    // enum containing foot, bicycle, ... , plane;
/* 3 */    bool bEnvironmentallyFriendly;
/* 6 */    SCurrency currencyRevenue;
/* 8 */    SCurrency currencyExpenditure;
/* 5 */    float fPercentageOfPeople;
};

// <NOTE> The following struct is crossed out.
// struct SPeople
// {
//     float fPercentage;
//     Method * method;

struct SPersonSurveyed
{
/* * */    Method * method;
/* 1 */    SDistance distance_to_travel;
/* 2 */    float fProbability;
/* 4 */    float fAffectOfCongestion;
/* 7 */    SCurrency currencyWeeklyCost;
/* 9 */    STime timeTravel;
};

// There are a few Methods and a large number
// of persons surveyed.  The methods contain
// in general known govt. data (revenue & expenditure.)

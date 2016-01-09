// <NOTE> This is for question 11
// <NOTE> From scan file:  accu05/SCAN0020.jpg - SCAN0021.jpg
//API Transport

// <NOTE> The following 3 structs were never declared.

struct SCurrency { int _DUMMY_FIELD;};
struct SDistance { int _DUMMY_FIELD;};
struct STime {int _DUMMY_FIELD; };

struct Method
{
    // enum containing foot, bicycle, ... , plane;
/* 3 */    _Bool bEnvironmentallyFriendly;  //* Method of transport is environment friendly
/* 6 */    struct SCurrency currencyRevenue;  //* Transport method tax revenue
/* 8 */    struct SCurrency currencyExpenditure;  //* Yearly expenditure on infrastructure supporting transport method
/* 5 */    float fPercentageOfPeople;  //* Percentage of workforce using transport method
};

// <NOTE> The following struct is crossed out.
// struct SPeople
// {
//     float fPercentage;
//     Method * method;

struct SPersonSurveyed
{
/* * */    struct Method * method;
/* 1 */    struct SDistance distance_to_travel;  //* Distance of travel
/* 2 */    float fProbability;  //* Probability of arriving on time
/* 4 */    float fAffectOfCongestion;  //* Arrival time affected by congestion
/* 7 */    struct SCurrency currencyWeeklyCost;  //* Weekly travel cost
/* 9 */    struct STime timeTravel;  //* Travel time
};

// There are a few Methods and a large number
// of persons surveyed.  The methods contain
// in general known govt. data (revenue & expenditure.)

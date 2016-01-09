// <NOTE> This is for question 5
// <NOTE> From scan file:  accu05/SCAN0010.jpg

enum TransportMethod
{
    Walking, Cycling, Car, Motorbike,
    Ferry, Train, Bus, Flying
};

struct Journey
{
/* * */    TransportMethod method;
/* 1 */    double duration;    // in minutes
/* 3 */    double congestion_effect;
/* 4 */    double distance;    // km
};

struct TravelSummary
{
/* * */    TransportMethod method;
/* 2 */    double weekly_travel_cost;  // average
// <NOTE> Probably not the following spelling
/* * */    double avg_distance;
/* 3 */    double avg_congestion_effect;
// <NOTE> Probably not the following spelling
/* * */    double avg_trace;
/* 5 */    double percentage_of_workforce;
/* 6 */    double probability_on_time;
/* 7 */    double tax_revenue_generated;
/* 8 */    double yearly_expenditure;
/* 9 */    bool environmentally_friendly;
};

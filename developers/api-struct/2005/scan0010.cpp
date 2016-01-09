// <NOTE> This is for question 5
// <NOTE> From scan file:  accu05/SCAN0010.jpg
//API Transport

enum TransportMethod
{
    Walking, Cycling, Car, Motorbike,
    Ferry, Train, Bus, Flying
};

struct Journey
{
/* * */    TransportMethod method;
/* 1 */    double duration;    // in minutes  //* Travel time 
/* 3 */    double congestion_effect;  //* Arrival time affected by congestion
/* 4 */    double distance;    // km  //* Distance to travel
};

struct TravelSummary
{
/* * */    TransportMethod method;
/* 2 */    double weekly_travel_cost;  // average  //* Weekly travel cost
// <NOTE> Probably not the following spelling
/* * */    double avg_distance;
/* 3 */    double avg_congestion_effect;  //* Arrival time affected by congestion
// <NOTE> Probably not the following spelling
/* * */    double avg_trace;
/* 5 */    double percentage_of_workforce;  //* Percentage of workforce using transport method
/* 6 */    double probability_on_time;  //* Probability of arriving on time
/* 7 */    double tax_revenue_generated;  //* Tax revenue from transport method
/* 8 */    double yearly_expenditure;  //* Yearly expenditure on infrastructure supporting transport method
/* 9 */    bool environmentally_friendly;  //* An environment friendly method of transport
};

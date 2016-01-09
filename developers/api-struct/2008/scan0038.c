// <NOTE> This is for question 101 
// <NOTE> From scan file:  08/scan0038.jpg
//API Transport

#include "typedefs.h"

#define WALKING
#define CYCLING
#define CAR
// actual numbers
// determined by a bit-mask
// that would include
// the Booleans for:



struct t_method {
/* * */    int type;
/* 1 */    float prob;  //* Arrival time probability
/* 2 */    float weekly;  //* Weekly travel cost
/* 3 */    float fixed_costs;  //* Infrastructure, yearly expenditure on, supporting transport method
/* 4 */    int congestion;  //* Arrival time affected by congestion
/* 5 */    float tax_revenue;  //* Tax revenue from transport method
/* 6 */    int travel_time;  //* Travel time
/* 7 */    int eco;  //* An environment friendly method of transport
/* 8 */    float distance;  //* Travel distance
/* 9 */    float percentage;  //* Percentage of workforce using transport method
};
// a small amount of enteries calls for simplicity


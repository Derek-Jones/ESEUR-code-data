// <NOTE> This is for question 102 
// <NOTE> From scan file:  08/scan0040.jpg
//API Resources

#include "typedefs.h"
typedef float time_t;

struct type
{
    // <NOTE> The following 2 comments are guesses
/* * */    int type;   // #define list
/* 2 */    int dispatch;   // #define list  //* Dispatch method (e.g., sea/air)
/* 4 */    float avg_shipment;  //* Raw material per shipment, average weight
/* 5 */    float shipping_cost;  //* Storage cost per week
/* 6 */    float extraction_cost;  //* Extraction cost per unit weight
/* 7 */    float unit_value;  //* Raw material value on commodity exchange
};

struct shipment
{
/* * */    int type;   // Key
/* 8 */    time_t minned;  //* Date raw material mined
/* 3 */    char * location;  //* Location mined from
    // value of shipment loaded up from type
};

// There will be many shipments - keep them small.

/* Ommitted
1)Production volume per week
*/

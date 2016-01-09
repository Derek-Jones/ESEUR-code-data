// <NOTE> This is for question 68
// <NOTE> From scan file:  accu05/SCAN0058.jpg
//API Transport

// <NOTE> These needed to be added.
#include <string.>
// using namespace std;

// <NOTE> The following types did not exist.
typedef long double  Decimal;
typedef float DateTime;
typedef char * string;

struct TransportType
{
/* * */    string name;
};

struct Transport
{
/* * */    string name;
/* * */    struct TransportType * type;
/* 2 */    Decimal cost;    // per week  //* Cost of travel per week
/* 9 */    _Bool ecoFriendly;   // <NOTE> The subject wrote "boolean"  //* An environment friendly method of transport
/* 8 */    Decimal populationUsage;  //* Percentage of workforce using transport method
};

struct Journey
{
/* 6 */    Decimal distance;  //* Distance to travel
/* * */    string StartLocation;
/* * */    string EndLocation;
/* 4 */    Decimal ProbabilityArrivalOk;  //* Probability of arriving on time
};

struct JourneyTime
{
/* * */    struct Journey * Journey;
/* * */    DateTime StartTime;
/* * */    DateTime EndTime;
};
/* Omitted
1)Travel time
3)Arrival time affected by congestion
5)Tax revenue from transport method
7)Yearly expenditure on infrastructure supporting transport method
*/


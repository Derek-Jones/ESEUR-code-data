// <NOTE> This is for question 68
// <NOTE> From scan file:  accu05/SCAN0058.jpg
//API Transport

// <NOTE> These needed to be added.
#include <string>
using namespace std;

// <NOTE> The following types did not exist.
typedef int Decimal;
typedef int DateTime;

class TransportType
{
/* * */    string name;
};

class Transport
{
/* * */    string name;
/* * */    TransportType * type;
/* 2 */    Decimal cost;    // per week  //* Cost of travel per week
/* 9 */    bool ecoFriendly;   // <NOTE> The subject wrote "boolean"  //* An environment friendly method of transport
/* 8 */    Decimal populationUsage;  //* Percentage of workforce using transport method
};

class Journey
{
/* 6 */    Decimal distance;  //* Distance to travel
/* * */    string StartLocation;
/* * */    string EndLocation;
/* 4 */    Decimal ProbabilityArrivalOk;  //* Probability of arriving on time
};

class JourneyTime
{
/* * */    Journey * Journey;
/* * */    DateTime StartTime;
/* * */    DateTime EndTime;
};
/* Omitted
1)Travel time
3)Arrival time affected by congestion
5)Tax revenue from transport method
7)Yearly expenditure on infrastructure supporting transport method
*/


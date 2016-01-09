// <NOTE> This is for question 68
// <NOTE> From scan file:  accu05/SCAN0058.jpg

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
/* 2 */    Decimal cost;    // per week
/* 9 */    bool ecoFriendly;   // <NOTE> The subject wrote "boolean"
/* 8 */    Decimal populationUsage;
};

class Journey
{
/* 6 */    Decimal distance;
/* * */    string StartLocation;
/* * */    string EndLocation;
/* 4 */    Decimal ProbabilityArrivalOk;
};

class JourneyTime
{
/* * */    Journey * Journey;
/* * */    DateTime StartTime;
/* * */    DateTime EndTime;
};

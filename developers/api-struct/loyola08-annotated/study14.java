//API Transport
/*
1 ) Travel time
2 ) Yearly expenditure on infrastructure supporting transport method
3 ) Method of transport is environment friendly
4 ) Probability of arriving on time
5 ) Percentage of workforce using transport method
6 ) Cost of travel per week
7 ) Congestion affects arrival time
8 ) Transport method tax revenue
9 ) Travel distance
*/

// <NOTE> Page 53

// <NOTE> The following class was added 
// <NOTE> so the code would compile.

public class study14 { }

class Trip 
{
     TransportType[] _modes; // multi-mode xport n
 /* 1 */ int _duration;  // resolution is not defined...  customer should specify
 /* 9 */ float _distance;    // metric system for all!  but...meters?  km?
 /* 6 */ int _costPerWeek;  // Is this really a reucurring trip?  Pretend it is.  
}


class TransportType
{
 /* 2 */  int _yearlySupportExpense;  // whole unit currency, but thousands, millions...??
 /* 3 */  boolean _enviormentallyFriendly;
 /* 4 */  float _onTimeProbability;  // valid values (0, 1]
 /* 5 */  float _popularity;  // valid values [0, 1]
 /* 7 */  boolean _congestionVulnerable;
 /* 8 */  int _taxRevenue; 
// Quarterly?  Yearly?  PLEASE SPECIFY.  
}

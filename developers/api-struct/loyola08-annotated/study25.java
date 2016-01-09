//API Transport
/*
1 ) An environment friendly method of transport
2 ) Congestion affects arrival time
3 ) Time spent travelling
4 ) Workforce percentage using transport method
5 ) Infrastructure, yearly expenditure on, supporting transport method
6 ) Transport method tax revenue
7 ) Distance to travel
8 ) Arrival time probability
9 ) Weekly travel cost
*/

// <NOTE> Page 29

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study25 { } 

class TransportMethod
{
  /* * */  int selfOrPass; // 0 or 1
  /* * */  int methodOfTransport;  // 0 to 3
  /* 1 */   boolean enviroFriendly;
  /* 2 */   boolean congestion; // unsure if this should be a number or a yes or no answer 
                  // but I chose a boolean.  true if it does effect, false if not.
  /* 3 */   double travelTime;  
                  // probably going to be in hours.  Minutes should not be ignored.
  /* 4 */   double workforcePerc;  // going to be a decimal .00 -> 1.0
  /* 5 */   double yearlyExpenditure;
  /* 6 */   double taxRevenue;
  /* 7 */   double distTravel;
  /* 8 */   double arrivalTimeProb; // once again, another decimal (probability) 
  /* 9 */   int weeklyCost; // round to nearest dollar
}

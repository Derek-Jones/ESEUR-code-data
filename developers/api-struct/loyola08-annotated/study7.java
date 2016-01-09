//API Transport
/*
1 ) Time spent travelling
2 ) Probability of arriving on time
3 ) Tax revenue from transport method
4 ) Workforce percentage using transport method
5 ) Cost of travel per week
6 ) Infrastructure, yearly expenditure on, supporting transport method
7 ) Congestion affects arrival time
8 ) Distance to travel
9 ) Method of transport is environment friendly
*/

// <NOTE> Page 110

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study7 { }

// [110]

/*abstract*/ class Transportation {
  /* * */  String type;  // Walking, flying, etc.
  /* 1 */   float timeSpent;  // or long timeSpent, if measuring in miliseconds 
  /* 2 */   float probabilityOfOnTime;  // 0.0 - 1.0 
  /* 5 */   float costPerWeek; 
  /* 7 */   boolean affectedByCongestion; 
  /* 8 */   float distance;
  /* 9 */   boolean environmentallyFriendly;
  /* 4 */   float workforcePercentage;  // 0.0 - 1.0 
}

class SelfDriven extends Transportation {
    // <NOTE> There are some lines crossed out that
    // <NOTE> are not readable
	 
    // nothing here that isn't in transportation
}

class Passenger extends Transportation {
  /* * */   float taxRevenue;
  /* 6 */   String infrastructure;  // ?
  /* 6 */   float expenditures;
  /* 6 */   String supportingMethod;  // ?
}

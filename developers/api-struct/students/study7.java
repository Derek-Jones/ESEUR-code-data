// <NOTE> Page 110

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study7 { }

// [110]

/* (abstract) */ class Transportation {
    String type;  // Walking, flying, etc.
    float timeSpent;  // or long timeSpent, if measuring in miliseconds
    float probabilityOfOnTime;  // 0.0 - 1.0
    float costPerWeek;
    boolean affectedByCongestion;
    float distance;
    boolean environmentallyFriendly;
    float workforcePercentage;  // 0.0 - 1.0
}

class SelfDriven extends Transportation {
    // <NOTE> There are some lines crossed out that
    // <NOTE> are not readable
	 
    // nothing here that isn't in transportation
}

class Passenger extends Transportation {
    float taxRevenue;
    String infrastructure;  // ?
    float expenditures;
    String supportingMethod;  // ?
}

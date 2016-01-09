// <NOTE> Page 29

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study25 { }

class TransportMethod
{
    int selfOrPass; // 0 or 1
    int methodOfTransport;  // 0 to 3
    boolean enviroFriendly;
    boolean congestion; // unsure if this should be a number or a yes or no answer
                        // but I chose a boolean.  true if it does effect, false if not.
    double travelTime;  // probably going to be in hours.  Minutes should not be ignored.
    double workforcePerc;   // going to be a decimal .00 -> 1.0
    double yearlyExpenditure;
    double taxRevenue;
    double distTravel;
    double arrivalTimeProb; // once again, another decimal (probability)
    int weeklyCost; // round to nearest dollar
}

// <NOTE> Page 98

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study18 { }

class Traveller
{
    MethodOfTransp preferredTranspMeans;
    double weeklyTravelBudget;
    Time weeklyTravelTime;
}

class Time
{
    int hr;
    int min;
}

class MethodOfTransp
{
    Time congestionEffects;
    double weeklyCost;
    double maintenanceCost;
    double revenueEarned;
    boolean enviro;
    double precentUse;
    double probTimelyArrival;
    boolean selfDriven;
}

class TranspSystem
{
    Traveller[] customers;
    MethodOfTransp[] transpOptions;
}

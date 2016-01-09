//API Transport
/*
1 ) Congestion affects arrival time
2 ) Distance to travel
3 ) Weekly travel cost
4 ) Time spent travelling
5 ) Infrastructure, yearly expenditure on, supporting transport method
6 ) Percentage of workforce using transport method
7 ) Tax revenue from transport method
8 ) An environment friendly method of transport
9 ) Probability of arriving on time
*/

// <NOTE> Page 98

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study18 { }

class Traveller 
{
/* * */        MethodOfTransp preferredTranspMeans;
/* * */        double weeklyTravelBudget;
/* 4 */       Time weeklyTravelTime;
}

class Time 
{
    int hr;
    int min;
}

class MethodOfTransp 
{
  /* 1 */   Time congestionEffects;
  /* 3 */   double weeklyCost;
  /* 5 */   double maintenanceCost;
  /* 7 */   double revenueEarned;
  /* 8 */   boolean enviro;
  /* 6 */   double precentUse;
  /* 9 */   double probTimelyArrival;
  /* 1 */   boolean selfDriven;
}

class TranspSystem
{
/* * */    Traveller[] customers;
/* * */    MethodOfTransp[] transpOptions;
}

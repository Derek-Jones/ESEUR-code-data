// <NOTE> This is for question 41
// <NOTE> From scan file:  08/scan0013.jpg
//API Transport

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class __DUMMY_CLASS { }

class TransportPeriod {
/* * */    Integer type;
 // It's not just Y/N, lets say 0-100
/* 3 */    Integer environmentallyFriendly;  //* Method of transport is environment friendly
/* 5 */    float yearlyExpenditure;  //* Yearly expenditure on infrastructure supporting transport method
/* 6 */    float usagePercentage;  //* Workforce percentage using transport method
/* 8 */    float taxRevenue;  //* Tax revenue from transport method
}

class UserCase {
/* * */    Integer type;
/* 1 */    Integer arrivalTime;  //* Arrival time affected by congestion
/* 4 */    float distance;  //* Travel distance
/* 7 */    Integer travelTime;  //* Travel time
/* 9 */    float onTimeProbability;  //* Probability of arriving on time
}

/* Ommitted
2)Weekly travel cost
*/


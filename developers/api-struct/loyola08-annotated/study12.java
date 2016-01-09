//API Transport
/*
  1 ) Arrival time affected by congestion
  2 ) Weekly travel cost
  3 ) Method of transport is environment friendly
  4 ) Travel distance
  5 ) Yearly expenditure on infrastructure supporting transport method
  6 ) Workforce percentage using transport method
  7 ) Travel time
  8 ) Tax revenue from transport method
  9 ) Probability of arriving on time
*/

// <NOTE> Page 41
// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study12 { }

class TransportMethod
{
 /* * */   boolean passenger;  // false -> self driven
 /* * */   String type;    // walking, car, etc... needs fxn to assert valid input
 /* 1 */   boolean traffic; 
 /* 2 */   double cost; 
 /* 3 */   boolean green; 
 /* 4 */   double distance; 
 /* 5 */   double budget; 
 /* 6 */   float workforce_percentage; 
 /* 7 */   double speed; 
 /* 8 */   double tax_revenue; 
 /* 9 */   float percent_late;
}

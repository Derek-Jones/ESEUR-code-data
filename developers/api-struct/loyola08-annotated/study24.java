//API Resources
/*
1 ) Production volume per week
2 ) Mining location
3 ) Average weight of raw material per shipment
4 ) Storage cost per week
5 ) Method of dispatch (e.g., sea/air)
6 ) Date raw material mined
7 ) Cost of extraction per unit weight
8 ) Raw material value on commodity exchange
*/

// <NOTE> Page 30

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study24 { }

class RawMaterial
{
  /* 1 */   float prodVal;
  /* 2 */   String miningLoc; // name of the location, though could be replaced
                          // with a float array if coordinates are preferred
  /* 3 */   float aveShipWeight;
  /* 4 */   float storeCost; 
  /* 5 */      String dispatch;
        // <NOTE> This subject tried to do something like
        // <NOTE> int[3] mydate;
        // <NOTE> which you can't do in Java.  I removed the 3.
  /* 6 */   int[] date; // To keep a standard format, methods will apply the values mm/dd/yyyy
  /* 7 */   float costPerUnit;
  /* 8 */   float value;
  /* * */       int type;   // will be 0 for precious stone or 1 for ore
  /* * */      int material;   // useless without "type", but will be 0-2 for the specific type
}

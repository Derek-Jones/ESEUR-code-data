// <NOTE> Page 30

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study24 { }

class RawMaterial
{
    float prodVal;
    String miningLoc;   // name of the location, though could be replaced
                        // with a float array if coordinates are preferred
    float aveShipWeight;
    float storeCost;
    String dispatch;
    // <NOTE> This subject tried to do something like
    // <NOTE> int[3] mydate;
    // <NOTE> which you can't do in Java.  I removed the 3.
    int[] date; // To keep a standard format, methods will apply the values mm/dd/yyyy
    float costPerUnit;
    float value;
    int type;   // will be 0 for precious stone or 1 for ore
    int material;   // useless without "type", but will be 0-2 for the specific type
}

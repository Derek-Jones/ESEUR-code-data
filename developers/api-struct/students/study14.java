// <NOTE> Page 53

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study14 { }

class Trip
{
    TransportType[] _modes; // multi-mode xport n
    int _duration;  // resolution is not defined...  customer should specify
    float _distance;    // metric system for all!  but...meters?  km?
    int _costPerWeek;   // Is this really a reucurring trip?  Pretend it is.
}

class TransportType
{
    int _yearlySupportExpense;  // whole unit currency, but thousands, millions...??
    boolean _enviormentallyFriendly;
    float _onTimeProbability;   // valid values (0, 1]
    float _popularity;  // valid values [0, 1]
    boolean _congestionVlunerable;
    int _taxRevenue;    // Quarterly?  Yearly?  PLEASE SPECIFY.
}

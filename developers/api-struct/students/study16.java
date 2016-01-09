// <NOTE> Page 54

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study16 { }

class Shipment
{
    RawMaterial _material;
    String _miningLocation;
    String _miningDate; // Assume earliest?  latest?
    String _dispatchMethod;
    float _storageCostPerWeek;
}

class RawMaterial
{
    int _costPerUnitWeight;
    int _commodityValue;
    float _volumePerWeek;   // National sale?
    float _avgShipmentWeight;
}

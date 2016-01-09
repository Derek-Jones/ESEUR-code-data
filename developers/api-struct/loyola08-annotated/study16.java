//API Resources
/*
1 ) Mining location
2 ) Extraction cost per unit weight
3 ) Method of dispatch (e.g., sea/air)
4 ) Raw material value on commodity exchange
5 ) Production volume per week
6 ) Weekly cost of storage
7 ) Raw material per shipment, average weight
8 ) Mining date of raw material
*/

// <NOTE> Page 54

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study16 { }

class Shipment
{
 /* 4 */ RawMaterial _material;
 /* 1 */ String _miningLocation;
 /* 8 */ String _miningDate; // Assume earliest?  latest?  
 /* 3 */ String _dispatchMethod;
 /* 6 */ float _storageCostPerWeek;
}

class RawMaterial
{
 /* 2 */  int _costPerUnitWeight;
 /* 4 */  int _commodityValue;
 /* 5 */ float _volumePerWeek; // National sale?
 /* 7 */ float _avgShipmentWeight; 
}

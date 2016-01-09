// <NOTE> Page 52

// <NOTE> The following class was added
// <NOTE> so the code would compile.

public class study15 { }

class Product
{
    String _geneticFamily;
    float _avgLaborCost;
    float _avgShipmentWeight;
    float _marketValue;
}

class Meat
{
    enum Type
    {
        Cattle, Sheep, Pig
    }
}

class Head
{
    Meat _type;
    String _lastVetInspection;
    String[] _antibiotics;
    String _birthDate;
    String _slaughterDate;
    String _pedigreeID;
}

// There is not nearly enough information to make good decisions
// about the data.  Whoever gathered requirements did poorly.

// <NOTE> The following is crossed out:
// class FarmOwner
// {
//     String _name;
// }

// <NOTE> The following class is unfinished.

class Farm
{
    String _owner;
    String _location;
}

// <NOTE> The following is crossed out:
// abstract class Product
// {
//     String _geneticFamily;
//     float _avgShipmentWeight;
// }
// 
// class Cereal
// {
//     enum CerealType
//     {
//         Barley,
//         Corn,
//         Wheat
//     }
// }

// <NOTE> This is the second Product class created.
// <NOTE> This one appears to be a work in progress,
// <NOTE> so it's commented out.

// class Product
// {
//     enum Type
//     {
//         Cattle, Sheep, Pig,
//         Barley, Corn, Wheat
//     }
// }

// weight of avg. shipment
// -> in general?  from this farm?
// why not just compute this?
// going with overall avg shipment weight

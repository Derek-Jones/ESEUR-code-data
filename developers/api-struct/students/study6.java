// <NOTE> Page 109

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study6 { }

// [109]

// I assumed multiple crops can be in one shipment.
// If I am wrong, then the weight field should be moved
// to the crop class, and the shipment class is no
// longer needed.

class Shipment {
    Crop[] crops;
    float weight;
}

class Crop {
    final int CEREAL = 0;
    final int FISH = 1;
    int type;  // Either CEREAL OR FISH
    Product product;
    Farm farm;
    boolean organic;
	 // <NOTE> Crossed out:  "float marketValues"
}

class Farm {
    String owner;
    String location;
    float numAcres;
}

/* (abstract) */ class Product {  // Could probably be made into an interface
    String type;  // barley, corn, trout, etc.
}

class Cereal extends Product {
    String seedSupplier;
    String weedKillerSprayed;  // Null if none used
    String fertilizerUsed;  // Null if none used
    float laborCost;  // Average
    String fieldLocation;
    String sownDate;
    String harvestDate;
}

class Fish extends Product {
    String pedigreeClass;
    String geneticFamily;  // ?
    float numAcresUsedForThis;
    String lastVetInspectionDate;
    String[] antiobioticsUsed;
    float animalRasingCost;
    String birthDate;
    String slaughterDate;
    float feedCosts;
}

// _Shipment_
// []Crops
// avg weight
//
// _Crop_
// type
// product
// farm
// acre of crop market value
// produced organically
// 
// _Cereal_ - > product-type
// seed supplier
// week killer sprayed
// fertilizer used
// labor cost
// location of field
// crop sown date
// harvest date
//
// _Fish_ -> product-type
// pedigree class
// genetic family
// farm acres
// date of vet inspec
// [] antibiotics used
// animal raising cost
// slaughter date
// birth date
// feed costs
//
// _Farm_
// owner
// location
// acres
//
// _Product_
// type

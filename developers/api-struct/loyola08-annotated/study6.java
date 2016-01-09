//API Agriculture
/*
  1 ) Crop harvest date
  2 ) Average shipment weight
  3 ) Owner of farm
  4 ) Pedigree class
  5 ) Supplier of seeds
  6 ) Weed killer sprayed
  7 ) Genetic family
  8 ) Fertilizer used
  9 ) Farm acres used to rear animals
  10 ) Location of farm
  11 ) Cost of fertilizer
  12 ) Date of last vet inspection
  13 ) Antibiotics used
  14 ) Acre of crop market value 
  15 ) Produced organically
  16 ) Animal raising average labor cost
  17 ) Animal slaughter date
  18 ) Average labor cost for growing crop
  19 ) Location of field
  20 ) Number of each kind of animal on farm 
  21 ) Market value of kind of animal
  22 ) Farm acres used to grow crops
  23 ) Animal birth date
  24 ) Feed-stuff costs
  25 ) Crop sown date
*/

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
  /* * */      Crop[] crops;
  /* 2 */   float weight;
}

class Crop {
/* * */    final int CEREAL = 0;
/* * */    final int FISH = 1;
/* * */    int type;  // Either CEREAL OR FISH
/* * */    Product product;
/* * */    Farm farm;
/* 15*/    boolean organic;
	 // <NOTE> Crossed out:  "float marketValues"
}

class Farm {
  /* 3 */   String owner; 
  /* 10 */   String location;
  /* 22 */   float numAcres;
}

/*abstract*/ class Product {  // Could probably be made into an interface
    String type;  // barley, corn, trout, etc.
}

class Cereal extends Product {
  /* 5 */   String seedSupplier;
  /* 6 */   String weedKillerSprayed;  // Null if none used
  /* 8 */   String fertilizerUsed; // Null if none used
  /* 18 */   float laborCost; // Average 
  /* 19 */   String fieldLocation;
  /* 25 */   String sownDate;
  /* 1 */   String harvestDate;
}

class Fish extends Product {
  /* 4 */   String pedigreeClass;
  /* 7 */   String geneticFamily; // ?  
  /* 9 */     float numAcresUsedForThis;
  /* 12 */   String lastVetInspectionDate;
  /* 13 */   String[] antiobioticsUsed;
  /* 16 */   float animalRasingCost;
  /* 23 */   String birthDate;
  /* 17 */   String slaughterDate;
  /* 24 */   float feedCosts;
}

// _Shipment_
// []Crops
//     avg weight 
//
// _Crop_
// type
// product
// farm
//     acre of crop market value 
//     produced organically 
// 
// _Cereal_ - > product-type
//      seed supplier 
//      week killer sprayed 
//      fertilizer used 
//      labor cost 
//      location of field 
//      crop sown date 
//      harvest date 
//
// _Fish_ -> product-type
//      pedigree class 
//      genetic family 
//      farm acres 
//      date of vet inspec 
//      [] antibiotics used 
//      animal raising cost 
//      slaughter date 
//      birth date 
//      feed costs 
//
// _Farm_
//      owner 
//      location 
//     acres
//
// _Product_
// type

//API Agriculture
/*
1 ) Acres used to grow crops
2 ) Pedigree ID
3 ) Genetic family
4 ) Location of field
5 ) Antibiotics used
6 ) Crop growing average labor costs
7 ) Cost of feed-stuff
8 ) Date crop harvested
9 ) Market value of acre of crop
10 ) Farm acres used to rear animals
11 ) Location of farm
12 ) Animal birth date
13 ) Produced organically
14 ) Farm owner
15 ) Date crop sown
16 ) Supplier of seeds
17 ) Animal raising average labor cost
18 ) Weed killer used
19 ) Number of each kind of animal on farm
20 ) Average shipment weight
21 ) Animal slaughter date
22 ) Date of last vet inspection
23 ) Fertilizer used
24 ) Market value of kind of animal
25 ) Fertilizer costs
*/

//API Agriculture
// <NOTE> Page 31

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study5 { }

// - 31 -

class Meat {
  /* 10 */    double animalFarmAcres;
  /* 17 */   double raiseAvgLaborCost;
  /* * */   AnimalFarm[] animalFarms;
}

class AnimalFarm {
  /* 4 */   String fieldLoc;
  /* 5 */   String[] antibioticsUsed;
  /* 7 */   double feedCost;
  /* * */   String[] animalKind;  // <NOTE> Crossed out:  "kindsOfAnimals" 
  /* 19 */      int[] kindNumbers;  // <NOTE> Crossed out:  "String" and "animal"
  /* 24 */   double[] kindMarketVal;  // <NOTE> Crossed out:  "String" and "animal" 
  /* * */      Animal[] animals;
}

class Animal {
  /* 2 */   int pedigreeID;
  /* 3 */   String geneticFamily;
  /* 12 */   String birthdate;
  /* 21 */   String slaughterDate; 
  /* 22 */   String lastVetDate;
}

class Cereal {
  /* 9 */   double cropAcres;
  /* 6 */   double cropAvgLabCost;
  /* 20 */   double avgShipWeight;
  /* * */      Farm[] farms;
}

class Farm {
  /* 11 */   String loc;  // <NOTE> Crossed out:  "farm" before "loc" 
  /* 14 */   String owner;
  /* 16 */   String seedSupplier;
  /* 18 */   String weedKillerUsed;
  /* 23 */   String fertilizerUsed;
  /* 25 */   double fertilizerCost;
  /* * */   Crop[] crops;
}

class Crop {
  /* 8 */   String harvestDate;
  /* 9 */   double marketValPerAcre;
  /* 13 */   boolean organic;
  /* 15 */   String sownDate;
}

// <NOTE> Page 31

// <NOTE> The following class declaration is so
// <NOTE> the code would compile.

public class study5 { }

// - 31 -

class Meat {
    double animalFarmAcres;
    double raiseAvgLaborCost;
    AnimalFarm[] animalFarms;
}

class AnimalFarm {
    String fieldLoc;
    String[] antibioticsUsed;
    double feedCost;
    String[] animalKind;  // <NOTE> Crossed out:  "kindsOfAnimals"
    int[] kindNumbers;  // <NOTE> Crossed out:  "String" and "animal"
    double[] kindMarketVal;  // <NOTE> Crossed out:  "String" and "animal"
    Animal[] animals;
}

class Animal {
    int pedigreeID;
    String geneticFamily;
    String birthdate;
    String slaughterDate;
    String lastVetDate;
}

class Cereal {
    double cropAcres;
    double cropAvgLabCost;
    double avgShipWeight;
    Farm[] farms;
}

class Farm {
    String loc;  // <NOTE> Crossed out:  "farm" before "loc"
    String owner;
    String seedSupplier;
    String weedKillerUsed;
    String fertilizerUsed;
    double fertilizerCost;
    Crop[] crops;
}

class Crop {
    String harvestDate;
    double marketValPerAcre;
    boolean organic;
    String sownDate;
}

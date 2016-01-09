// <NOTE> This is for question 7
// <NOTE> From scan file:  accu05/SCAN0013.jpg - SCAN0014.jpg

#include "typedefs.h"

struct Farm
{
    // <NOTE> "struct" was left out of the
    // <NOTE> following 2 declarations.
/* * */    struct AnimalOnFarm * animals;
/* * */    struct CropOnFarm * crops;
/* 8 */    char * location;    // 8
/* 18 */    int acreageCrop;    // 18
/* 25 */    char * owner;   // 25
/* 3 */    int acreageAnimals; // 3
/* 2 */    char * dateVetInspection;   // 2
/* 22 */    char ** fieldLocation;  // 22
/* 11 */    double fertilizerCost;  // 11
/* 4 */    double feedCost;    // 4
};

struct AnimalOnFarm
{
/* * */    Animal_t type;  // implies 5
/* 9 */    char * dateBorn;    // 9
/* 17 */    char * dateSlaughter;   // 17
/* 15 */    BOOL antibiotics;   // 15
/* 20 */    char * geneticID;   // 20
/* 12 */    char * pedigreeID;  // 12
};

struct CropOnFarm
{
/* 3 */    char * usedSupplier;    // 3
/* 6 */    char * dateHarvest; // 6
/* 7 */    BOOL fertilized;    // 7
/* 19 */    char * dateSown;    // 19
/* 21 */    BOOL weedKilled;    // 21
/* 24 */    BOOL organic;   // 24
};

struct Farming  // the whole thing
{
    // <NOTE> The following 3 declarations
    // <NOTE> were missing "struct".
/* * */    struct Crop * crops;
/* * */    struct Animal * animals;
/* * */    struct Farm * farm;
};

struct Crop
{
/* 14 */    double valuePerField;   // 14
/* 13 */    double weightAvShipment;    // 13
/* 16 */    double avLabourCost;    // 16
};

struct Animal
{
/* 1 */    double marketValue; // 1
/* 10 */    double avLabourCost;    /// 10
};

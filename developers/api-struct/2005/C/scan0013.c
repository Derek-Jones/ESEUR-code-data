// <NOTE> This is for question 7
// <NOTE> From scan file:  accu05/SCAN0013.jpg - SCAN0014.jpg
//API Agriculture

#include "typedefs.h"

struct Farm
{
    // <NOTE> "struct" was left out of the
    // <NOTE> following 2 declarations.
/* * */    struct AnimalOnFarm * animals;
/* * */    struct CropOnFarm * crops;
/* 8 */    char * location;    // 8  //* Farm location
/* 18 */    int acreageCrop;    // 18  //* Farm acres used to grow crops
/* 25 */    char * owner;   // 25  //* Farm owner
/* 23 */    int acreageAnimals; // 23  //* Farm acres used to rear animals
/* 2 */    char * dateVetInspection;   // 2  //* Date of last vet inspection
/* 22 */    char ** fieldLocation;  // 22  //* Location of field
/* 11 */    double fertilizerCost;  // 11  //* Fertilizer costs
/* 4 */    double feedCost;    // 4  //* Cost of feed-stuff
};

struct AnimalOnFarm
{
/* * */    Animal_t type;  // implies 5
/* 9 */    char * dateBorn;    // 9  //* Date animal born
/* 17 */    char * dateSlaughter;   // 17  //* Date animal slaughtered
/* 15 */    _Bool antibiotics;   // 15  //* Antibiotics used
/* 20 */    char * geneticID;   // 20  //* Genetic ID
/* 12 */    char * pedigreeID;  // 12  //* Pedigree ID
};

struct CropOnFarm
{
/* 3 */    char * seedSupplier;    // 3  //* Seed supplier
/* 6 */    char * dateHarvest; // 6  //* Date crop harvested
/* 7 */    _Bool fertilized;    // 7  //* Fertilizer used
/* 19 */    char * dateSown;    // 19  //* Date crop sown
/* 21 */    _Bool weedKilled;    // 21  //* Weed killer used
/* 24 */    _Bool organic;   // 24  //* Was organically produced
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
/* 14 */    double valuePerField;   // 14  //* Market value of field of crop
/* 13 */    double weightAvShipment;    // 13  //* Weight of average shipment
/* 16 */    double avLabourCost;    // 16  //* Average labor costs for growing crop
};

struct Animal
{
/* 1 */    double marketValue; // 1  //* Market value of kind of animal
/* 10 */    double avLabourCost;    // 10  //* Average labor costs for raising kind of animal
};

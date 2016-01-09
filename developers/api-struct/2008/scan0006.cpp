// <NOTE> This is for question 37
// <NOTE? 08/scan0006.c
//API Agriculture

// <NOTE> The following was included so the code would compile.

#include "typedefs.h"

// <NOTE> (crossed out) start at end ---date is individual for arrivals?

#define CATTLE 0
#define SHEEP 1
#define PIGS 2
#define BARLEY 0
#define CORN 1
#define WHEAT 2

// Genetic ID?
// A field can grow various agricultural products? (NO)
// An agricultural product can be grown on different fields?

struct product_t {
/* 3 */  float weightAverageShipped;  //* Average shipment weight of agricultural product
/* 4 */  float nbrAcresDedicated;  //* Acres dedicated to creation of agricultural product
/* 2 */  char* nameAntibioticOrChemicalUsedP; //* Antibiotics / Chemicals used
/* 5 */  bool isOrganic;  //* Was organically produced
/* 9 */  float valueMarket; //* Market value of agricultural product
/* 15 */  time_t dateStartLife;  //* Agricultural product started life date
// <NOTE> (cross out) struct life date
/* 10 */  time_t dateEndLife; //* Agricultural product end life date
// <NOTE> (cross out) end life date
/* 12 */  float costAverageOfLabour; //* Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing
/* 12 */  float costOfGrowing;  //* Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing
/* 8 */  char * locationOfFieldP;  //* Field locations holding agricultural product
};

struct farm_t {
/* 1 */  char* ownerP;  //* Farm owner
/* 6 */  char* locationP; //* Location of farm
/* 7 */  size_t nbrMeat;  //* Number of each kind of agricultural product on farm
/* * */  product_t meatP [3];
/* 7 */  size_t nbrCereals; //* Number of each kind of agricultural product on farm
/* * */  product_t cerealP [3];
/* 14 */  time_t dateLastInspection;  //* Date of last official agricultural product food safety inspection
};

/* Ommitted
11)Genetic ID
13)Agricultural product average labour costs
*/


// <NOTE> This is for question 109
// <NOTE> From scan file:  08/scan0049.jpg and scan0050.jpg
//API Agriculture

#include "typedefs.h"
#include <time.h>
struct farm;

#define NUMFISH 3

// C-style Solution

// <NOTE> The following is crossed out:
// <NOTE> class farm
// <NOTE> {
// <NOTE>     string owner;
// <NOTE>     string location;
// <NOTE> }

struct crop
{
/* * */    struct farm * originatingFarm;
/* 1 */    time_t harvestTime;  //* Crop harvest date
/* 2 */    double averageWeight;   // units?  //* Average shipment weight
/* * */    enum {barley, corn, wheat} type;
/* 5 */    char * supplier;  //* Supplier of seeds
/* 6 */    char * weedkillerName;  //* Weed killer sprayed
/* 8 */    char * fertilizerName;  //* Fertilizer used
/* 22 */    double acreage;  //* Farm acres used to grow crops
/* 11 */    double fertilizerCost;  //* Cost of fertilizer
/* 14 */    double valuePerAcre;  //* Acre of crop market value
/* 15 */    _Bool organic;  //* Produced organically
/* 18 */    double labourCost;  //* Average labor cost for growing crop
/* 19 */    char * fieldLocation;  //* Location of field
/* 25 */    time_t sownDate;  //* //* Crop sown date
};

struct farm
{
/* 3 */    char * owner;  //* Owner of farm
/* 10 */    char * location;  //* Location of farm
/* * */    double arable;
/* 20 */    long fishCount[NUMFISH];  //* Number of each kind of animal on farm
};

struct animal
{
/* * */    struct farm * orginatingFarm;
/* * */    enum {salmon, trout, eel} type;
/* 12 */    time_t lastVetInspection;  //* Date of last vet inspection
/* 13 */    _Bool antibioticsUsed;  //* Antibiotics used
/* 15 */    _Bool organic;  //* Produced organically
/* 16 */    double labourCost;  //* Animal raising average labor cost
/* 17 */    time_t slaughterDate;  //* Animal slaughter date
/* 21 */    double marketValue;  //* Market value of kind of animal
/* 23 */    time_t birthDate;  //* Animal birth date
/* 24 */    double costOfFeed;  //* Feed-stuff costs
};

// 'owner' and 'location' in farm and 'supplier' in crop will probably actually
// be pointers to additional record types not specified.
//
// Rationale
// - Not enough information yet available to decide if a more hierarchical data
// structure would be appropriate
// - Convention required for currency of amounts [$ or cent]
// Crops/animals need to have originating farm, don't currently need reverse connection.
// Not entirely persuaded that the animal struct is right.
// The information requested doesn't match my expectations.
// Would there be more than 1 weed killer or fertilizer?

/* Ommitted
4) Pedigree class
7) Genetic family
9) Farm acres used to rear animals
*/


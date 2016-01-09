// <NOTE> This is for question 31-1
// <NOTE> From scan file:  05/imag0051.jpg
//API Agriculture

#include "typedefs.h"
typedef unsigned long time_t;

// Using UNIX_style time_t (unsigned seconds since epoch for fixed time period )
#define NO_PRODUCTS 6

enum PROP_TYPES {BARLEY, CORN, WHEAT, SALMON, TROUT, EELS};

struct Products
{
/* * */    enum PROP_TYPES type;
/* 2 */    _Bool Organic;  //* Was organically produced
/* 3 */    unsigned AverageLaborCost;  //* Average labor costs of agricultural product
/* 5 */    char *Field[__DUMMY_LITERAL];  //* Location of fields holding agricultural product
/* * */    unsigned NoFields;
/* 12 */    time_t StartedLife;  //* Agricultural product started life date
/* 4 */    time_t EndLife;  //* Agricultural product end life date
/* 6 */    char *GeneticId;  //* Genetic ID
/* 7 */    unsigned ValuePerKilogram; // use with below info to determine total  //* Market value of agricultural product
/* 10 */    double AverageShipmentWeight;  //* Average shipment weight of agricultural product
/* 14 */    double AcresUsed;  //* Farm acres dedicated to creation of agricultural product
/* 13 */    char *Chemicals[__DUMMY_LITERAL];  //* Chemicals / Antibiotics used
/* 15 */    unsigned GrowthCosts;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
};

// <NOTE> struct Farm moved to bottom of file to enable code to compile

// (unsigned seconds sine epoch for fixed time point)
struct Farm
{
/* 1 */    time_t LastInspection;  //* Date of last official agricultural product food safety inspection
/* 9 */    char *OwnerName;  //* Farm owner
/* 11 */    char *Address;  //* Farm location
/* 8 */    struct Products __DUMMY_FIELD[NO_PRODUCTS];    //size is no of products on this farm  //* Number of each kind of agricultural product on farm
};

// <NOTE> This is for question 106
// <NOTE> From scan file:  08/scan0047.jpg
//API Agriculture

#include "typedefs.h"

typedef enum { name1, name2 } Chemicals;

typedef enum { organic, traditional } CropType;
typedef struct { int seconds; } Date;
typedef struct { int pennies; } Currency;

typedef struct {
/* 1 */    __DUMMY_TYPE average_cost;  //* Costs (e.g., Feed-stuff and Fertilizer) for agricultural product growing
/* 4 */    Chemicals * chem;  //* Chemicals / Antibiotics used
/* 2 */    Date kill;  //* Date agricultural product killed
/* 5 */    GenID genid;  //* Genetic ID
/* 7 */    Date visit;  //* Date of last official agricultural product food safety inspection
/* 8 */    Date start;  //* Date agricultural product started life
/* * */    CropType type;
/* 11 */    weight AVweight;  //* Agricultural product average shipment weight
/* 12 */    Currency value;  //* Agricultural product market value
/* 13 */    Currency labour;  //* Average labor costs of agricultural product
} Product_t;

// <NOTE> The following 3 typedefs needed to be moved
// <NOTE> before the previous struct.
// <NOTE> typedef enum { organic, traditional } CropType;
// <NOTE> typedef struct { int pennies; } Currency;
// <NOTE> typedef struct { int seconds; } Date;

typedef enum { Barley, Corn, Wheat, Salmon, Trout, Eels } Products;

typedef struct
{
    // ...
    Products * products;
} Location_t;

// <NOTE> The following typedef needed to be moved
// <NOTE> before the previous struct.
// <NOTE> typedef enum { Barley, Corn, Wheat, Salmon, Trout, Eels } Products;

/* Ommitted
3) Farm location
6) Location of fields holding agricultural product
9) Was organically produced
10) Farm acres dedicated to creation of agricultural product
14) Owner of farm
15) Number of each kind of agricultural product on farm
*/


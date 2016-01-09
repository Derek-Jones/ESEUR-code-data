// <NOTE> This is for question 115
// <NOTE> From scan file:  08/scan0058.jpg and scan0059.jpg
//API Agriculture

#include "typedefs.h"

// Almost every piece of information requires questions for further clarification.
//
// I shall proceed having made guess about the answers
// In reality I would not guess, obviously . 
// the order of data items reflects the order on the opposite page. 
// I would plan to re-order later were I not using paper.

// <NOTE> enum moved so the code would compile.
enum EAnimalTypeCode
{
    salmon,
    trout,
    eel
};

struct AnimalType
{
/* * */    EAnimalTypeCode animal_type_code;
/* 18 */    double market_value;  //* Market value of kind of animal
/* 16 */    double average_raising_labor_cost;  //* Animal raising average labor cost
/* 21 */    double cost_of_feed_stuff;  //* Cost of feed-stuff
};

// <NOTE> enum EAnimalTypCode moved from here

#define NULL_DATE -1000000

struct Animal
{
/* * */    struct AnimalType * type;
/* 3 */    _Bool produced_organically;  //* Produced organically
/* 4 */    const char * genetic_id;  //* Genetic ID
/* 5 */    double slaughter_date;  // Seconds since 1970 - same  //* Animal slaughter date
                            // arbitrary value (e.g. -1000000) indicates
                            // "still alive"
/* 7 */    double last_vet_inspection_date;    // As above, -1000000 means "not inspected" //* Last vet inspection date
/* 8 */    const char * pedigree_id;  //* Pedigree ID
/* 9 */    _Bool antibiotics_given;  //* Antibiotics given
/* 25 */    double born_date;  //* Date animal born
};

// cont'd next page

// <NOTE> The following structs/enum were incomplete.

struct AnimalFarm
{
int _DUMMY_FIELD;
};

enum ECropTypeCode
{
    __DUMMY_ENUMID
};

struct CropType
{
int _DUMMY_FIELD;
};

struct Crop
{
    struct CropType * type;
};

struct CropFarm
{
    double longitude;
    double latitude;
};

/* Ommitted
1) Weed killer sprayed
2) Field location
6) Fertilizer costs
10)Supplier of seeds
11)Average shipment weight
12)Cost of feed-stuff
13)Location of farm
14)Crop sown date
15)Fertilizer applied
17)Date crop harvested
19)Supplier of seeds
20)Average shipment weight
22)Location of farm
23)Crop sown date
24)Fertilizer applied
*/


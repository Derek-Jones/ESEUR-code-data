// <NOTE> This is for question 13
// <NOTE> From scan file:  accu05/SCAN0024.jpg - SCAN0025.jpg

#include "typedefs.h"

#define ANIMAL_TYPE int
#define COW 0
#define SHEEP 1
#define PIG 2

// <NOTE> BOOL already exists in "typedefs.h" so this had to be commented out.
// typedef unsigned char BOOL;

#define CROP_TYPE int
#define BARLEY 0
// ...

struct date
{
/* * */    int day;
/* * */    int month;
/* * */    int year;
};

struct location
{
/* * */    double latitude;
/* * */    double longitude;
};

struct cost
{
/* * */    double amount;
};

struct value
{
/* * */    double amount;
};

struct animal
{
/* * */    ANIMAL_TYPE type;
/* 4 */    date birth_date;
/* 16 */    date slaughter_date;
/* 5 */    int pedigree_id;
/* 9 */    int generic_id;
/* 23 */    BOOL organically_produced;
};

// <NOTE> This struct needed to be relocated above the "field" struct so the
// <NOTE> code would compile.
struct crop
{
/* 23 */    BOOL organic;
/* 17 */    double av_ship_weight;
/* * */    CROP_TYPE type;
/* 15 */    date date_sown;
/* 14 */    date date_harvested;
/* 6 */    char * weed_killer;
/* 2 */    cost labor_cost;
/* 11 */    value value_per_field;
/* 12 */    char * fertilizer;  // assume we only use 1 per crop
};

struct field
{
/* * */    location loc;
/* * */    crop crops;
};

// <NOTE> moved: struct crop

struct farm
{
/* 1 */    char * owner;
/* 3 */    animal cows[NUM_COWS];
/* 3 */    animal sheep[NUM_SHEEP];
/* 3 */    animal pigs[NUM_PIGS];
/* 7 */    location farm_location;
/* * */    field fields[NUM_FIELDS];
/* 25 */    double animal_acres;
/* 19 */    double crop_acres;

/* 22 */    value cow_value;
/* 22 */    value sheep_value;
/* 22 */    value pig_value;
/* 21 */    char * seed_supplier;

/* 10 */    cost cow_feed_cost;
/* 10 */    cost sheep_feed_cost;
/* 10 */    cost pig_feed_cost;

/* 2 */    cost sheep_labor_cost;
/* 2 */    cost cow_labor_cost;
/* 2 */    cost pig_labor_cost;
};

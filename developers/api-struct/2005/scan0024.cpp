// <NOTE> This is for question 13
// <NOTE> From scan file:  accu05/SCAN0024.jpg - SCAN0025.jpg
//API Agriculture

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
/* 4 */    date birth_date;  //* Date animal born
/* 16 */    date slaughter_date;  //* Animal slaughter date
/* 5 */    int pedigree_id;  //* Pedigree ID
/* 9 */    int generic_id;  //* Genetic ID
/* 23 */    BOOL organically_produced;  //* Was organically produced
};

// <NOTE> This struct needed to be relocated above the "field" struct so the
// <NOTE> code would compile.
struct crop
{
/* 23 */    BOOL organic;  //* Was organically produced
/* 17 */    double av_ship_weight;  //* Weight of average shipment
/* * */    CROP_TYPE type;
/* 15 */    date date_sown;  //* Date crop sown
/* 14 */    date date_harvested;  //* Date crop harvested
/* 6 */    char * weed_killer;  //* Weed killer used
/* 2 */    cost labor_cost;  //* Average labor cost for raising kind of animal
                               /* Market value of ORIGINALLY ->field<- of crop
/* 11 */    value value_per_field;  //* Market value of acre of crop
/* 12 */    char * fertilizer;  // assume we only use 1 per crop  //* Fertilizer costs
};

struct field
{
/* * */    location loc;
/* * */    crop crops;
};

// <NOTE> moved: struct crop

struct farm
{
/* 1 */    char * owner;  //* Farm owner
/* 3 */    animal cows[NUM_COWS];  //* Number of each kind of animal on farm
/* 3 */    animal sheep[NUM_SHEEP];  //* Number of each kind of animal on farm
/* 3 */    animal pigs[NUM_PIGS];  //* Number of each kind of animal on farm
/* 7 */    location farm_location;  //* Location of farm
/* * */    field fields[NUM_FIELDS];
/* 25 */    double animal_acres;  //* Farm acres used to rear animals
/* 19 */    double crop_acres;  //* Farm acres used to grow crops

/* 22 */    value cow_value;  //* Market value of kind of animal
/* 22 */    value sheep_value;  //* Market value of kind of animal
/* 22 */    value pig_value;  //* Market value of kind of animal
/* 21 */    char * seed_supplier;  //* Seed supplier

/* 10 */    cost cow_feed_cost;  //* Feed-stuff costs
/* 10 */    cost sheep_feed_cost;  //* Feed-stuff costs
/* 10 */    cost pig_feed_cost;  //* Feed-stuff costs

/* 2 */    cost sheep_labor_cost;  //* Average labor cost for raising kind of animal
/* 2 */    cost cow_labor_cost;  //* Average labor cost for raising kind of animal
/* 2 */    cost pig_labor_cost;  //* Average labor cost for raising kind of animal
};

// <NOTE> This is for question 13
// <NOTE> From scan file:  accu05/SCAN0024.jpg - SCAN0025.jpg
//API Agriculture

// #include "typedefs.h"

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
/* 4 */    struct date birth_date;  //* Date animal born
/* 16 */    struct date slaughter_date;  //* Animal slaughter date
/* 5 */    int pedigree_id;  //* Pedigree ID
/* 9 */    int generic_id;  //* Genetic ID
/* 23 */    _Bool organically_produced;  //* Was organically produced
};

// <NOTE> This struct needed to be relocated above the "field" struct so the
// <NOTE> code would compile.
struct crop
{
/* 23 */    _Bool organic;  //* Was organically produced
/* 17 */    double av_ship_weight;  //* Weight of average shipment
/* * */    CROP_TYPE type;
/* 15 */    struct date date_sown;  //* Date crop sown
/* 14 */    struct date date_harvested;  //* Date crop harvested
/* 6 */    char * weed_killer;  //* Weed killer used
/* 2 */    struct cost labor_cost;  //* Average labor costs for raising kind of animal
/* 11 */    struct value value_per_field;  //* Market value of field of crop
/* 12 */    char * fertilizer;  // assume we only use 1 per crop  //* Fertilizer costs
};

struct field
{
/* * */    struct location loc;
/* * */    struct crop crops;
};

// <NOTE> moved: struct crop

struct farm
{
/* 1 */    char * owner;  //* Farm owner
/* 3 */    struct animal cows[NUM_COWS];  //* Number of each kind of animal on farm
/* 3 */    struct animal sheep[NUM_SHEEP];  //* Number of each kind of animal on farm
/* 3 */    struct animal pigs[NUM_PIGS];  //* Number of each kind of animal on farm
/* 7 */    struct location farm_location;  //* Location of farm
/* * */    struct field fields[NUM_FIELDS];
/* 25 */    double animal_acres;  //* Farm acres used to rear animals
/* 19 */    double crop_acres;  //* Farm acres used to grow crops

/* 22 */    struct value cow_value;  //* Market value of kind of animal
/* 22 */    struct value sheep_value;  //* Market value of kind of animal
/* 22 */    struct value pig_value;  //* Market value of kind of animal
/* 21 */    char * seed_supplier;  //* Seed supplier

/* 10 */    struct cost cow_feed_cost;  //* Feed-stuff costs
/* 10 */    struct cost sheep_feed_cost;  //* Feed-stuff costs
/* 10 */    struct cost pig_feed_cost;  //* Feed-stuff costs

/* 2 */    struct cost sheep_labor_cost;  //* Average labor costs for raising kind of animal
/* 2 */    struct cost cow_labor_cost;  //* Average labor costs for raising kind of animal
/* 2 */    struct cost pig_labor_cost;  //* Average labor costs for raising kind of animal
};

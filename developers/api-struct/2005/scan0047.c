// <NOTE> This is for question 28
// <NOTE> From scan file:  05/scan0047.jpg
//API Agriculture

struct farm
{
/* 16 */    char* owner;  //* Owner of farm
/* 6 */    unsigned crop_acres;  //* Farm acres used to grow crops
/* 2 */    unsigned animal_acres;  //* Farm acres used to rear animals
/* 25 */    char* location;  //* Farm location
};

struct animal_type
{
/* 22 */    unsigned market_value;  //* Market value of kind of animal
/* 4 */    unsigned average_cost_to_raise;  //* Average labor cost for raising kind of animal
};

//individual annual record
struct animal 
{
/* 18 */    unsigned date_born;  //* Date animal born
/* 5 */    unsigned date_slaughtered;  //* Date animal slaughtered
/* 20 */    unsigned date_last_vet_inspection;  //* Date of last vet inspection
/* 10 */    char *pedigree_ID;  //* Pedigree ID
};

struct field_use
{
/* * */    int year;
/* 13 */    unsigned date_sewn;              //days since epoch
/* 9 */    char * location;  //* Location of field
/* 21 */    char * weedkiller_used;  //* Weed killer used
/* 3 */    char * seed_supplier;  //* Seed supplier
/* 8 */    unsigned data_harvested;  //* Crop harvest date
};

struct crop_type
{
/* 1 */    char * genetic_id;  //* Genetic ID
/* 19 */    unsigned average_cost_to_grow;  //* Average labor cost for growing crop
};

/*
Animals: 
Date born  18
Date ----- 20
Slaughtered --
Type--
--Pedigree

Farm:
Location --25
Owned by --
Crop acres 5
Aminals used 2

Animal-type:
----- 4
market value 22
cost of field struct –20

field:
date seen –13
---8
Fertilizer---
Weed killer---
Date harvested 8
};
*/

// Crop type: 
 
// I would have pointer to instance of other structs to indicate relationships, rather than type
// enumeration (#defines) where possible.  Eg. animal type in animals is indicated by a
// reference (pointer) to appropriate instance of animal-type struct.

// In practice it would be insane to go through this exercise without knowing about how the
// data would be used!
/* Omitted
7)Fertilizer costs
11)Produced organically
12)Average shipment weight
13)Date crop sown
14)Fertilizer used
15)Number of each kind of animal on farm
17)Market value of field of crop
23)Antibiotics used
24)Cost of feed-stuff
*/


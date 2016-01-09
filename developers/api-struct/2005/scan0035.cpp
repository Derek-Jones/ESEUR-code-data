// <NOTE> This is for question 19
// <NOTE> From scan file:  accu05/SCAN0035.jpg - SCAN0037.jpg
//API Agriculture

// <NOTE> My apologies, but this particular subject's
// <NOTE> handwriting is horrendous.  Many of the fields
// <NOTE> are guesses.

// In the absence of an inheritance <NOTE> No idea what the
// previous word is </NOTE> mechanism, use a discriminated union
// to case memory manipulation lists etc.
//
// It appears one requirments to provide information on farm
// <NOTE> Again, the previous word is unreadable so "farm" is
// a guess </NOTE>, animals, not cited is the two forms or
// arguments.

#define CEREAL_GROUP 1
#define FISH_GROUP 2
#define ANIMAL_GROUP 3
#define BARLEY 1
#define CORN 2
#define WHEAT 3
#define SALMON 1
#define TROUT 2
#define EELS 3
#define UNDEFINED 0
#define MAX_ANIMAL_CODE 1

typedef int currency;

struct cereal_record
{
/* * */    int Cereal_Type;
/* 2 */    int Fertilizer_Code;    // Assume 0.1 treatment per bale,  //* Fertilizer used
                            // in fact would probably be more
                            // linked date per treatment.
/* 16 */    currency Fertilizer_Cost;  //* Fertilizer costs
/* 6 */    int weed_killer_Code;   // As above  //* Weed killer used
/* 3 */    int harvest_Date;   // service date  //* Crop harvest date
/* 17 */    int Sow_Date;  //* Crop sown date
/* * */    int Field_Id;
/* * */    int owner_Id;
/* 13 */    bool ISOrganic;  //* Was organically produced
/* 14 */    int SeedSupplierID;  //* Seed supplier
};

struct fish_record
{
};

struct animal_record
{
/* * */    int FieldID;    // assumes animals only line in one field
/* * */    int OwnerID;
/* 7 */    currency FeedCost;  //* Cost of feed-stuff
/* 9 */    int AntibioticCode;  //* Antibiotics used
/* 13 */    bool isOrganic;  //* Was organically produced
/* 18 */    int BirthDate;  //* Date animal born
/* 24 */    int SlaughterDate;  //* Animal slaughter date
/* 21 */    int InspectionDate;  //* Last vet inspection date
/* 12 */    int Pedigree;  //* Pedigree ID
};

struct produce_record
{
/* * */    int Rates_num;
/* * */    float RatesYeildEverything;
/* 5 */    int GeneticID;  //* Genetic ID
/* 19 */    currency Labour_cost;  //* Average labor cost for raising kind of animal
/* 20 */                           //* Average labor cost for growing crop
/* * */    int Group;
/* 4 */    currency Value;  //* Market value of kind of animal
/* * */    union {
/* * */        struct Cereal_Record Cereal;
/* * */        struct Fish_Record Fish;
/* * */        struct Animal_Record Animal;
    };
};

// <NOTE> These structs needed to be relocated to before the previous
// <NOTE> struct cereal_record
// <NOTE> struct fish_record
// <NOTE> struct animal_record

struct farm
{
/* * */    int OwnerID;
/* 10 */    char * OwnerName;  //* Owner of farm
/* 15 */    char * Address;  //* Location of farm
/* 23 */    int numAnimals[Max_Animal_Code];  //* Number of each kind of animal on farm
/* * */    int NumFields;

    struct
    {
/* * */        int fieldID;
/* 11 */        float size;  //* Farm acres used to grow crops
/* 11 */                     //* Farm acres used to rear animals
/* * */        float cost;
/* * */	float leg; // <NOTE> Could also include other letters
/* * */    } Fields[__DUMMY_CONST];
};

/* Omitted
1)Average shipment weight
8)Location of field
25)Market value of field of crop
*/


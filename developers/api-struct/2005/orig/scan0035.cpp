// <NOTE> This is for question 19
// <NOTE> From scan file:  accu05/SCAN0035.jpg - SCAN0037.jpg

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
/* 2 */    int Fertilizer_Code;    // Assume 0.1 treatment per bale,
                            // in fact would probably be more
                            // linked date per treatment.
/* 16 */    currency Fertilizer_Cost;
/* 6 */    int weed_killer_Code;   // As above
/* 3 */    int harvest_Date;   // service date
/* 17 */    int Sow_Date;
/* * */    int Field_Id;
/* * */    int owner_Id;
/* 13 */    bool ISOrganic;
/* 14 */    int SeedSupplierID;
};

struct fish_record
{
};

struct animal_record
{
/* * */    int FieldID;    // assumes animals only line in one field
/* * */    int OwnerID;
/* 7 */    currency FeedCost;
/* 9 */    int AntibioticCode;
/* 13 */    bool isOrganic;
/* 18 */    int BirthDate;
/* 24 */    int SlaughterDate;
/* 21 */    int InspectionDate;
/* 12 */    int Pedigree;
};

struct produce_record
{
/* * */    int Rates_num;
/* * */    float RatesYeildEverything;
/* 5 */    int GeneticID;
/* 19 */    currency Labour_cost;
/* 20 */
/* * */    int Group;
/* 4 */    currency Value;
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
/* 10 */    char * OwnerName;
/* 15 */    char * Address;
/* * */    int numAnimals[Max_Animal_Code];
/* * */    int NumFields;

    struct
    {
/* * */        int fieldID;
/* 11 */        float size;
/* * */        float cost;
/* * */	float eg; // <NOTE> Could also include other letters
/* * */    } Fields;
};

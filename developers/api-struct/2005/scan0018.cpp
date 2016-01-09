// <NOTE> This is for question 10
// <NOTE> From scan file:  accu05/SCAN0018.jpg - SCAN0019.jpg
//API Agriculture

// <NOTE> These #includes were added so the code would compile.
#include <vector>
using namespace std;

struct SLocation { };
struct SWeight { };

// <NOTE> The following structs needed to be
// <NOTE> added so the code would compile.
struct SAcreage { };
struct SAnimalType { };

struct SFarm
{
/* 21 */    char * owner;  //* Owner of farm
/* 23 */    SLocation location;  //* Farm location
/* 1 */    SWeight weight_of_avg_shipment;  //* Weight of average shipment
/* 15 */    SAcreage acres_crops;  //* Farm acres used to grow crops
/* 25 */    SAcreage acres_animals;  //* Farm acres used to rear animals
/* 3 */    vector<pair<SAnimalType, int> > animal_counts;  //* Number of each kind of animal on farm
    // same idea as above for crops
};

// <NOTE> The following 2 structs needed to be
// <NOTE> moved to the top of the file so the code
// <NOTE> would compile.
// struct SLocation { };
// struct SWeight { };

// (To provide type safety and reuse!)

// <NOTE> The subject created what appears to be a list of structure
//        fields, so put it into a form that can be processed by the
//        field order awk script.

/*
   struct  _Farm_  */
/* 1 */  /* Weight of average shipment
/* 3 */  /* No. animals on  of each type
/* 21 */ /* Owner
/* 23 */ /* Location
/* 15 */ /* Acreage for crops
/* 25 */ /* Acres for animals
/*
  struct _Animal_  */
/* 12 */ /* DOB
/* 9 */  /* Slaughter date
/* 2 */  /* Antibiotics
/* 8 */  /* Cost of feed
/* 20 */  /* Genetic ID
/*
  struct _Crop_  */
/* 7 */  /* Harvest Date
/* 5 */  /* Fertilizer costs
/* 10 */ /* Seed supplier
/* 11 */ /* Fertilizer used
/* 14 */ /* Date sown
/* 18 */ /* Field location
/* 22 */ /* Weed killer
/*
  struct _Animal Type_  */
/* 13 */ /* Value
/* 19 */ /* Pegdigree ID
/* 24 */ /* Cost
//
  struct _Produce_  */
/* 4 */ /* Organic?
/*
  struct _Crop Type_  */
/* 6 */  /* Market value of field of crop
/* 17 */ /* Average labor costs

*/

// Structs SAnimal and SCrop derive (or include) a Produce
// struct which specifies organicness.
// --
// Note difference between a type of crop/animal and an
// actual shipment of crop or individual animal.

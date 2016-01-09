// <NOTE> This is for question 97
// <NOTE> From scan file:  08/scan0032.jpg - scan0033.jpg
//API Agriculture

#include "typedefs.h"

struct FarmInfo {
/* 6 */    double animalRearingAcres_; //* Farm acres used to rear animals
/* 14 */    double cropAcres_;  //* Acres used to grow crops
/* 17 */    std::string ownerId_;  //* Owner of farm
/* 15 */    std::map<std::string, int> animalCounts_;  //* Number of each kind of animal on farm
/* 12 */    GeographicInfo location;  //* Location of farm
/* 5 */    std::vector<FieldInfo> fields_; //* Location of field
};

struct FieldInfo {
/* * */    GeographicInfo location;
};

struct CropInfo {
/* 3 */    Date harvestDate_; //* Date crop harvested
    // <NOTE> Crossed out:  Fertilizer const * fertilizer;
/* 20 */    Date sownDate_;  //* Crop sown date
/* 8 */    std::string<std::vector> fertilizersApplied_;  //* Fertilizer applied
/* 7 */    std::string seedSupplierName_;  //* Seed supplier
/* 11 */    bool organicallyProduced_;  //* Was organically produced
};

struct AnimalSpeciesInfo {
/* * */    std::string speciesName_;
/* 1 */    double labourCostPerAnimal_;  //* Average labor cost for raising kind of animal
/* 23 */    double marketValue_;  //* Market value of kind of animal
/* 16 */    double feedStuffCost_;  //* Cost of feed-stuff
};

struct PlantSpeciesInfo {
/* * */    std::string speciesName_;
/* 18 */    double acreValue_;  //* Acre of crop market value
/* 9 */    double labourCost_;  //* Average labor cost for growing crop
};

struct AnimalInfo {
/* 4 */    date lastVetInspection_; //* Date of last vet inspection
/* 13 */    std::vector<std::string> antibioticsReceived_;  //* Antibiotics given
/* 24 */    Date slaughterDate_;  //* Animal slaughter date
/* 21 */    Date birthDate_;  //* Date animal born
/* 11 */    bool organicallyProduced_;  //* Was organically produced
};

// <NOTE> This is unfinished:
// <NOTE> struct Fert

struct GeographicInfo {
    // f.b.d. - address or coordinates?
};

// Approach taken was to identify static reference data and information pertaining to a farm, 
// field or particular product. Was unsure whether to have information on a per creature 
// basis or per herd. Also potential problems with changes to "static" reference data over 
// time for historical records.
// Also unsure how to represent relationships between entities. Suspect C++ not a good 
// implementatiuon language because of object lifetime management difficulties and 
// guaranteeing referential integrity. Would prefer SQL/relational DB.

/* Ommitted
2) Cost of fertilizer
10) Pedigree class 
19) Genetic ID
22) Weed  killer sprayed
25) Average shipment weight 
*/


// <NOTE> This is for question 25
// <NOTE> From scan file:  05/imag0042.jpg, scan0043.jpg, scan0044.jpg
//API Agriculture

#include "typedefs.h"

#define NEVER 0 // date value for things that haven't happened

struct farm 
{
/* 7 */    int cropAcres;	//not predicting change of use for all of any land- any form may change  //* Farm acres used to grow crops
/* 15 */    int meatAcres;  //* Farm acres used to rear animals

/* 18 */    char * location; 	//eg postcode or good ref-- otherwise would have an address structure here instead  //* Location of farm
/* 11 */    boolean isOrganic; 	//need more domain info to confirm that a mixed farm wouldn't get organic certification if only part of its production is organic  //* Produced organically
/* 21 */    long costVetInspection; // Saves space, facilitates data presentation maths and in any desired format of stored in an integer format.  Initialize to NEVER  //* Date of last vet inspection
};

// <NOTE> old location of field array	
 
#define MAX_ANIMALS_IN_FIELD __DUMMY_LITERAL // <approximate number> // allow for shoulder to shoulder chickens)

// <NOTE> struct animal was not defined by subject
struct animal { int __DUMMY_FIELD;}; // <REMOVE>

struct field
{
/* 14 */    char * location; 	//e.g. grid ref. If this is insufficient detail a description - string (for example) would be readed too.  //* Location of field

/* 2 */    char * fertilizerName; // form a list, not free format  //* Fertilizer used
/* * */    long dateFertilizerUsed;

/* * */    struct animal __DUMMY_ID1[MAX_ANIMALS_IN_FIELD]; 	//again, this is a quick, simple a nasty hack -- needs more sophisticated structure

/* 4 */    long dateHarvested;  //* Date crop harvested
/* 8 */    int fertilizerCost; 	//assuming this means how much spent- but a historical record with more detail of fertilizer range would be more appropriate  //* Fertilizer costs
};

// <NOTE> declaration moved for compilation
#define MAX_NO_OF_FIELDS __DUMMY_LITERAL // <approximate value>
/* * */struct field DUMMY_ID2 [MAX_NO_OF_FIELDS];

//Remember to limit the no. of fields artificially like this, but there's probably a limit to how big farms can be on an island!! 
/* Omitted
1)Animal slaughter date
3)Pedigree ID
5)Genetic ID
6)Animal birth date
9)Market value of field of crop
10)Average shipment weight
12)Feed-stuff costs
13)Farm owner
16)Crop growing average labor costs
17)Market value of kind of animal
19)Date crop sown 
20)Number of each kind of animal on farm 
22)Weed killer used
23)Supplier of seeds
24)Antibiotics used
25)Average labor cost for raising kind of animal
*/


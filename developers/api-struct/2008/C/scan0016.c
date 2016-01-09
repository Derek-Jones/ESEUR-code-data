// <NOTE> This is an answer for question 52
// <NOTE> 08/scan0016.c
//API Agriculture

// <NOTE> The following #include was added so the code will compile

#include "typedefs.h"
typedef double Date;
typedef char * string;

enum CROPTYPE {
       Barley,
       Corn,
       Wheat
      };

struct CROP {
/* 2 */	_Bool weedkiller;  //* Weed killer used
/* 12 */	Date sown;  //* Crop sown date
/* 11 */	Date harvest;  //* Date crop harvested
/* 14 */	unsigned int harvestweight;  //* Weight of average shipment
/* * */	struct CROP_INFO *info;
/* * */	struct FIELD *fields;
/* 19 */	struct FERTILISER *fertiliser;  //* Fertilizer applied
	};

struct CROPINFO {
/* 1 */	unsigned int mktvalue;  //* Market value of acre of crop
/* 16 */	string supplier;  //* Supplier of seeds
/* 9 */	unsigned int labourCost;  //* Average labor cost for growing crop
/* * */	struct CROP *crops;
/* * */	enum CROPTYPE type;
	};

struct FERTILISER {
/* 15 */	unsigned int unitcost;  //* Cost of fertilizer
	};

struct FIELD {
/* 22 */	GPS location;  //* Location of field
/* * */	unsigned int size;
/* * */	struct CROP *crop;
/* * */	struct ANIMAL *animal;
	};

struct ANIMAL {
/* 13 */	Date vet;  //* Date of last vet inspection
/* 18 */	_Bool antibiotics;  //* Antibiotics used
/* 3 */	Date Slaughterdate;  //* Animal slaughter date
/* * */	unsigned int  SlaughterWeight;
/* 25 */	Date born;  //* Date animal born
/* * */	struct ANIMALINFO *info;
/* * */	struct FIELD *fields;
	};

enum __DUMMY_TAG {
      cattle,
      sheep,
      pigs
     };

struct ANIMALINFO {
/* 6 */	unsigned int labourcost;  //* Average labor cost for raising kind of animal
/* * */	enum __DUMMY_TAG type;
/* * */	struct ANIMAL *crops;
	};

struct FAMILY {
/* * */	string name;
/* 17 */	string pedigreeID;  //* Pedigree ID
	};

struct FARM {
/* 10 */	string owner;  //* Owner of farm
/* 4 */	GPS location;  //* Location of farm
/* * */	struct CROP *crops;
/* * */	struct FIELD *fields;
/* * */	struct ANIMAL *animal;
	};

/* 20) Was organically produced
 *     infer from antibiotics/fertilizer/weedkiller
 */
/* 23) Acres used to grow crops
 *     Infer from size of fields and which contain crops
 */

/* Ommitted
5) Acres used to rear animals
7) Genetic family
8) Cost of feed-stuff
21) Market value of kind of animal
24) Number of each kind of animal on farm
*/


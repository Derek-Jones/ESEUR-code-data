// <NOTE> This is for question 31-2
// <NOTE> From scan file:  05/imag0051.jpg
//API Agriculture

typedef unsigned long time_t; // Epoch band for dates

enum PRODUCT_TYPES
{	
    NO_PRODUCT = 0, 
    BARLEY = 1,
    CORN, 
    WHEAT, 
    SALMON = 0x4,  //mask & shifts to select product groups
    TROUT,
    EEELS,
    LAST_PRODUCT
};
			
struct Product
{
/* * */	enum PRODUCT_TYPES type;
/* * */	unsigned NumOfFields;
/* 5 */	char *Fields[__DUMMY_LITERAL]; //one for each field //* Location of fields holding agricultural product
/* 2 */	_Bool Organic;  //* Was organically produced
/* 13 */	char *Chemicals; //includes antibiotics  //* Chemicals / Antibiotics used
/* 15 */	unsigned GrowthCosts;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
/* 3 */	unsigned AverageLaborCost; //unsigned --xxxnies to avoid roundoff error  //* Average labor costs of agricultural product
/* 6 */	char *GeneticId;  //* Genetic ID
/* 7 */	unsigned ValuePerKilo;  //* Market value of agricultural product
/* 10 */	double AverageShipmentWeight;  //* Average shipment weight of agricultural product
/* 14 */	double AcresUsed;  //* Farm acres dedicated to creation of agricultural product
/* 12 */	time_t StartLife;  //* Agricultural product started life date
/* 4 */	time_t EndLife;  //* Agricultural product end life date
};

struct Farm 
{
/* 9 */	char *OwnerName;  //* Farm owner
/* 11 */	char *Address;  //* Farm location
/* 1 */	time_t LastInspection;  //* Date of last official agricultural product food safety inspection
/* * */	struct Product Products[LAST_PRODUCT];
};

// Each enty in the products array is indexed by type.  NB: consistency check,
// as Type must match index, or be NO_PRODUCT.

// Split allows code to select relevant data only-determine value of product as one
// fn, type unsigned, fn (struct products).
// Then iterate over filtered list separately.
/* Omitted
8)Number of each kind of agricultural product on farm
*/


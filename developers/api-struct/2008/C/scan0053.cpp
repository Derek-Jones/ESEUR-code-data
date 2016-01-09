// <NOTE> This is for question 112
// <NOTE> From scan file:  08/scan0053.jpg
//API Agriculture

#include "typedefs.h"

#include <stddef.h>

struct Produce
{
/* * */    char * product_name;
/* 3 */    double growth_costs;  //* Agricultural product growth costs (e.g., Feed-stuff and Fertilizer)
/* 7 */    double labour_costs;  //* Average labor costs of agricultural product
/* 8 */    unsigned long life_start_date; /* julian day #  */  //* Date agricultural product started life
/* 12 */    unsigned long life_end_date;  //* Agricultural product end life date
/* 10 */    double shipment_weight;  //* Average shipment weight of agricultural product
/* * */    size_t  chemicals_used_count;
/* 4 */    chemical * chemicals_used;  //* Antibiotics / Chemicals used
/* 5 */    char *  genetic_id;  //* Genetic ID
/* 11 */    double  market_value;  //* Agricultural product market value
/* 13 */    _Bool    organically_produced;  //* Was organically produced
// <NOTE> crossed out char * field_location
/* 15 */    double  acres_used;  //* Farm acres dedicated to creation of agricultural product
/* * */    size_t field_locations_count;
/* 2 */    char ** field_locations;  //* Field locations holding agricultural product
};

struct ProductTypes;

struct Farm
{
/* 1 */    char * owner_name;  //* Owner of farm
/* 6 */    unsigned long last_inspection_date;  //* Date of last official agricultural product food safety inspection
/* 9 */    unsigned product_type_count;  //* Number of each kind of agricultural product on farm
/* * */    struct ProductTypes * product_type;
};

struct ProductTypes
{
/* * */    enum Etype {meat, cereals};
/* * */    Etype type;
/* * */    size_t products_count;
/* * */    struct Product * products;
};

/* Ommitted
14) Farm location
*/

